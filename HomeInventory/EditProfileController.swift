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
    
    var profile: Profile? = nil
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var streetAddress: UITextField!
    
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var stateField: UITextField!
    
    @IBOutlet weak var zipField: UITextField!

    @IBOutlet weak var phoneNumber: UITextField!
    
    
    @IBAction func submitButton(sender: AnyObject) {
        
        let realm = try! Realm()
        
        if (self.profile != nil) {
            let profile = Profile()
            
            profile.id = (profile.id)
            profile.fName = self.firstName.text!
            profile.lName = self.lastName.text!
            profile.street = self.streetAddress.text!
            profile.city = self.cityField.text!
            profile.state = self.stateField.text!
            profile.zip = self.zipField.text!
            profile.phone = self.phoneNumber.text!

            
            try! realm.write {
                realm.add(profile, update: true)
            }

        } else {
            let profile = Profile()
            
            profile.fName = self.firstName.text!
            profile.lName = self.lastName.text!
            profile.street = self.streetAddress.text!
            profile.city = self.cityField.text!
            profile.state = self.stateField.text!
            profile.zip = self.zipField.text!
            profile.phone = self.phoneNumber.text!
            
            try! realm.write {
                realm.add(profile)
            }
        }
                
        print("profile: ", profile)
        
        performSegueWithIdentifier("showProfile", sender: self)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupUI() {
        
        let realm = try! Realm() // Create realm pointing to default file
        
        print("profile passed: ", profile)
        
        if let profile = realm.objects(Profile).first {
            firstName.text = profile.fName
            lastName.text = profile.lName
            streetAddress.text = profile.street
            cityField.text = profile.city
            stateField.text = profile.state
            zipField.text = profile.zip
            phoneNumber.text = profile.phone
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
