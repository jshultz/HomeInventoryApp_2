//
//  RoomViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/30/15.
//  Copyright © 2015 HashRocket. All rights reserved.
//

import UIKit
import CoreData

class RoomViewController: UIViewController, UITextFieldDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var room: Rooms? = nil
    
    @IBOutlet weak var roomNameField: UITextField!
    
    @IBAction func submitButton(sender: AnyObject) {
        
        let entityDescription = NSEntityDescription.entityForName("Rooms", inManagedObjectContext: managedObjectContext)
        
        let room = Rooms(entity: entityDescription!,
            insertIntoManagedObjectContext: managedObjectContext)
        
        room.name = roomNameField.text
        
        do {
            try managedObjectContext.save()
            print("you made it?")
            navigationController?.popViewControllerAnimated(true)
        } catch {
            print("something bad happened")
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        roomNameField.resignFirstResponder()
        return true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
