//
//  EditProfileController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/28/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit
import CoreData

class EditProfileController: UIViewController, UITextFieldDelegate {
    
    var profile: Profile? = nil
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var streetAddress: UITextField!
    
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var stateField: UITextField!
    
    @IBOutlet weak var zipField: UITextField!

    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBAction func btnSave(sender: AnyObject) {
        
        // create an app delegate variable
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // context is a handler for us to be able to access the database. this allows us to access the CoreData database.
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        
        // see if we are updating a LegoSet or not?
        let request = NSFetchRequest(entityName: "Profile")
        
        if (self.profile != nil) {
            // if we want to search for something in particular we can use predicates:
            request.predicate = NSPredicate(format: "id = %@", self.profile!.id!) // search for users where username = Steve
        } else {

        }
        
        // by default, if we do a request and get some data back it returns false for the actual data. if we want to get data back and see it, then we need to set this as false.
        request.returnsObjectsAsFaults = false
        
        do {
            // save the results of our fetch request to a variable.
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    result.setValue(self.profile!.id, forKey: "id")
                    result.setValue(self.firstName.text, forKey: "fName")
                    result.setValue(self.lastName.text, forKey: "lName")
                    result.setValue(self.streetAddress.text, forKey: "street")
                    result.setValue(self.cityField.text, forKey: "city")
                    result.setValue(self.stateField.text, forKey: "state")
                    result.setValue(self.zipField.text, forKey: "zip")
                    result.setValue(self.phoneNumber.text, forKey: "phone")
                }
                
            } else {
                // we are describing the Entity we want to insert the new user into. We are doing it for Entity Name Users. Then we tell it the context we want to insert it into, which we described previously.
                let profile = NSEntityDescription.insertNewObjectForEntityForName("LegoSets", inManagedObjectContext: context)
                
                profile.setValue(self.profile!.id, forKey: "id")
                profile.setValue(self.firstName.text, forKey: "fName")
                profile.setValue(self.lastName.text, forKey: "lName")
                profile.setValue(self.streetAddress.text, forKey: "street")
                profile.setValue(self.cityField.text, forKey: "city")
                profile.setValue(self.stateField.text, forKey: "state")
                profile.setValue(self.zipField.text, forKey: "zip")
                profile.setValue(self.phoneNumber.text, forKey: "phone")
            }
            
        } catch {
            
        }
        
        do {
            // save the context.
            try context.save()
            performSegueWithIdentifier("showProfile", sender: self)
        } catch {
            print("There was a problem")
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupUI() {
        
        self.view?.backgroundColor = UIColor(red: 0.1176, green: 0.6902, blue: 1, alpha: 1.0) /* #1eb0ff */
        
        if (self.profile != nil) {
            firstName.text = self.profile!.fName
            lastName.text = self.profile!.lName
            streetAddress.text = self.profile!.street
            cityField.text = self.profile!.city
            stateField.text = self.profile!.state
            zipField.text = String(self.profile!.zip)
            phoneNumber.text = self.profile!.phone
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showProfile" {
            let profileController:ProfileController = segue.destinationViewController as! ProfileController
            
            profileController.profile = self.profile
        }
        
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
