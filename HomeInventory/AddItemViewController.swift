//
//  AddItemViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/31/15.
//  Copyright © 2015 HashRocket. All rights reserved.
//

import UIKit
import CoreData

class AddItemViewController: UIViewController, UITextFieldDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var room: Rooms? = nil
    
    @IBOutlet weak var itemNameField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var purchasePriceField: UITextField!
    
    @IBOutlet weak var purchaseDateField: UITextField!
    
    
    @IBAction func doneButton(sender: AnyObject) {
        purchaseDateField.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("the room: ", room)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func purchaseDateEdit( sender: AnyObject) {
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        purchaseDateField.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)

        
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.dateFormat = "dd MMM yyyy"
        purchaseDateField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func submitButton(sender: AnyObject) {
        
        let inventoryEntity = NSEntityDescription.entityForName("Inventory", inManagedObjectContext: managedObjectContext)
        
        let newItem = Inventory(entity: inventoryEntity!,
            insertIntoManagedObjectContext: managedObjectContext)
        
        newItem.setValue(itemNameField.text, forKey: "name")
        newItem.setValue(descriptionField.text, forKey: "item_description")
        

//        item.purchased_date = NSDate(purchaseDateField.text)
//        item.purchase_price = purchasePriceField.text
        
        do {
            try managedObjectContext.save()
        } catch {
            print("the cake was a lie")
        }
        
        // Add Address to Person
        room!.setValue(NSSet(object: newItem), forKey: "rooms_to_items")
        
        do {
            try room!.managedObjectContext?.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
        
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
