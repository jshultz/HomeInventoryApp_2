//
//  ViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/28/15.
//  Copyright © 2015 HashRocket. All rights reserved.
//

import UIKit
import CoreData

class ProfileController: UIViewController {
    
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var streetLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fetchLocation() {
        
        var objects = NSObject()
        let entityDescription = NSEntityDescription.entityForName("Profile", inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        
        request.entity = entityDescription
        
        do {
            var objects = try managedObjectContext.executeFetchRequest(request)
            
            if objects.count > 0 {
                let match = objects[0] as! NSManagedObject
                
                firstName.text = match.valueForKey("fName") as! String
                lastName.text = match.valueForKey("lName") as! String
                streetLabel.text = match.valueForKey("street") as! String
                cityLabel.text = match.valueForKey("city") as! String
                stateLabel.text = match.valueForKey("state") as! String
                numberLabel.text = match.valueForKey("phone") as? String

            } else {
                print("belly up")
            }
            
        } catch {
            print("why is the rum always empty?")
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

