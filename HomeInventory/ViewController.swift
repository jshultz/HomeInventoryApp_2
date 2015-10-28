//
//  ViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/28/15.
//  Copyright © 2015 HashRocket. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let entityDescription = NSEntityDescription.entityForName("Profile", inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        
        request.entity = entityDescription
        
        do {
            var objects = try managedObjectContext.executeFetchRequest(request)
        } catch {
            print("why is the rum always empty?")
        }
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

