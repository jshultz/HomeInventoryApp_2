//
//  AddItemViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/31/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit
import RealmSwift


class AddItemViewController: UIViewController, UITextFieldDelegate {
        
    var room: Room? = nil
    
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
                
        let realm = try! Realm()
        // Add row via dictionary. Order is ignored.
        
        let item = Inventory()
        
        item.name = self.itemNameField.text!
        item.item_description = self.descriptionField.text!
        item.purchased_date = self.purchaseDateField.text!
        item.purchase_price = self.purchasePriceField.text!
                
        try! realm.write {
            realm.add(item)
            self.room!.items.append(item)
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
