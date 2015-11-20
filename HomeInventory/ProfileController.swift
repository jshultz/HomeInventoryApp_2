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
    
    func fetchLocation() {
        
        let realm = try! Realm() // Create realm pointing to default file
        
        if let profile = realm.objects(Profile).first {
            firstName.text = profile.fName
            lastName.text = profile.lName
            streetLabel.text = profile.street
            cityLabel.text = profile.city
            stateLabel.text = profile.state
            numberLabel.text = profile.phone
        }
        
        
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        fetchLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

