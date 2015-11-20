//
//  EditProfileController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/28/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit
import RealmSwift


class EditProfileController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var streetAddress: UITextField!
    
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var stateField: UITextField!
    
    @IBOutlet weak var zipField: UITextField!

    @IBOutlet weak var phoneNumber: UITextField!
    
    
    @IBAction func submitButton(sender: AnyObject) {
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue) {
            // Get new realm and table since we are in a new thread
            let realm = try! Realm()
            // Add row via dictionary. Order is ignored.
            
            let profile = Profile()
            
            profile.fName = self.firstName.text!
            profile.lName = self.lastName.text!
            profile.street = self.streetAddress.text!
            profile.city = self.cityField.text!
            profile.state = self.stateField.text!
            profile.zip = self.zipField.text!
            
            try! realm.write {
                realm.add(profile)
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    func textFieldShouldReturn(textfield: UITextField) -> Bool {
//        descriptionField.resignFirstResponder()
//        return true
//    }
    
    
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
