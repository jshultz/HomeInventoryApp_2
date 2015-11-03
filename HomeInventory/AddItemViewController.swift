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
    
    @IBOutlet weak var purchaseDateField: UITextField!
    
    
    @IBAction func doneButton(sender: AnyObject) {
        purchaseDateField.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
