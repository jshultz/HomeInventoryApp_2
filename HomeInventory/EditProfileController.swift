//
//  EditProfileController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/28/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit


class EditProfileController: UIViewController, UITextFieldDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var streetAddress: UITextField!
    
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var stateField: UITextField!
    
    @IBOutlet weak var zipField: UITextField!

    @IBOutlet weak var phoneNumber: UITextField!
    
    
    @IBAction func submitButton(sender: AnyObject) {
        
        let entityDescription = NSEntityDescription.entityForName("Profile", inManagedObjectContext: managedObjectContext)
        
        let profile = Profile(entity: entityDescription!,
            insertIntoManagedObjectContext: managedObjectContext)
        
        profile.fName = firstName.text
        profile.lName = lastName.text
        profile.street = streetAddress.text
        profile.city = cityField.text
        profile.state = stateField.text
        profile.zip = Int(zipField.text!)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("the cake was a lie")
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
