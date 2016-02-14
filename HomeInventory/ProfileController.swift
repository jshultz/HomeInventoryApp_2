//
//  ViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/28/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileController: UIViewController {
    
    let realm = try! Realm()
    var profile:Profile? = nil
    var notificationToken: NotificationToken?
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var streetLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupUI() {
        
        self.view?.backgroundColor = UIColor(red: 0.1176, green: 0.6902, blue: 1, alpha: 1.0) /* #1eb0ff */
        
        if let profile = realm.objects(Profile).first {
            firstName.text = profile.fName
            lastName.text = profile.lName
            streetLabel.text = profile.street
            cityLabel.text = profile.city
            stateLabel.text = profile.state
            numberLabel.text = profile.phone
            
            self.profile = profile
            
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        
        if segue.identifier == "editProfile" {
            print("profile: ", self.profile)
            let editProfileController:EditProfileController = segue.destinationViewController as! EditProfileController
            
            if (profile != nil) {
                editProfileController.profile = self.profile
            } else {
                editProfileController.profile = nil
            }
            
        }
        
    }



}

