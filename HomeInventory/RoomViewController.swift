//
//  RoomViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/30/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit
import CoreData

class EditRoomViewController: UIViewController, UITextFieldDelegate {
    
    var room: Rooms? = nil
    
    @IBOutlet weak var roomNameField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBAction func cancelButton(sender: AnyObject) {
        if (self.room != nil) {
            performSegueWithIdentifier("showRoomInventory", sender: self)
        } else {
            performSegueWithIdentifier("showRooms", sender: self)
        }
    }
    
    
    @IBAction func saveButton(sender: AnyObject) {
        
        // create an app delegate variable
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // context is a handler for us to be able to access the database. this allows us to access the CoreData database.
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        
        // see if we are updating a LegoSet or not?
        let request = NSFetchRequest(entityName: "Rooms")
        
        if (self.room != nil) {
            // if we want to search for something in particular we can use predicates:
            request.predicate = NSPredicate(format: "id = %@", self.room!.id!) // search for users where username = Steve
        }
        
        
        // by default, if we do a request and get some data back it returns false for the actual data. if we want to get data back and see it, then we need to set this as false.
        request.returnsObjectsAsFaults = false
        
        do {
            // save the results of our fetch request to a variable.
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    result.setValue(self.roomNameField.text!, forKey: "name")
                    result.setValue(self.descriptionField.text!, forKey: "room_description")
                }
                
            } else {
                // we are describing the Entity we want to insert the new user into. We are doing it for Entity Name Users. Then we tell it the context we want to insert it into, which we described previously.
                let newSet = NSEntityDescription.insertNewObjectForEntityForName("Rooms", inManagedObjectContext: context)
                
                newSet.setValue(self.roomNameField.text!, forKey: "name")
                newSet.setValue(self.descriptionField.text!, forKey: "room_description")
            }
            
        } catch {
            
        }
        
        do {
            // save the context.
            try context.save()
            self.performSegueWithIdentifier("showRooms", sender: self)
        } catch {
            print("There was a problem")
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupUI() {
        if (self.room != nil) {
            self.title = self.room?.name
            roomNameField.text = self.room?.name
            descriptionField.text = self.room?.room_description
        }
        
        self.view?.backgroundColor = UIColor(red: 0.1176, green: 0.6902, blue: 1, alpha: 1.0) /* #1eb0ff */
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        roomNameField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        setupUI()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showRoomInventory" {
            
            let inventoryController:InventoryTableViewController = segue.destinationViewController as! InventoryTableViewController
            
            inventoryController.room = self.room
            
        } else if segue.identifier == "showRooms"{

        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
