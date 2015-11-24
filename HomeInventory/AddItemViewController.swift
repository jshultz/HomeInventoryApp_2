//
//  AddItemViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/31/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit
import RealmSwift
import Photos
import PhotosUI


class AddItemViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var room: Room? = nil
    
    var item: Inventory? = nil
    
    var return_room: Room? = nil
    
    var notificationToken: NotificationToken?
    
    var imageFilePath:String = ""
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var createButton: UIButton!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var itemNameField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var purchasePriceField: UITextField!
    
    @IBOutlet weak var purchaseDateField: UITextField!
    
    @IBAction func addPhotoButton(sender: AnyObject) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        purchaseDateField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
        setupUI()
    }
    
    func setupUI() {
        if (item != nil) {
            self.title = item?.name
            itemNameField.text = item?.name
            descriptionField.text = item?.item_description
            purchaseDateField.text = item?.purchased_date
            purchasePriceField.text = item?.purchase_price
            createButton.setTitle("Submit Changes", forState: UIControlState.Normal)
            
            
        } else {
            self.title = room?.name
        }

    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func purchaseDateEdit( sender: AnyObject) {
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        purchaseDateField.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    // Get path for a file in the directory
    
    func fileInDocumentsDirectory(filename: String) -> String {
        return getDocumentsDirectory().stringByAppendingPathComponent(filename)
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        
        return documentsDirectory
    }
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.dateFormat = "dd MMM yyyy"
        purchaseDateField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    func saveImage (image: UIImage, path: String ) -> String{
        
        let pngImageData = UIImagePNGRepresentation(image)
        //let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        let result = pngImageData!.writeToFile(path, atomically: true)
        return path
        
    }
    
    @IBAction func submitButton(sender: AnyObject) {
        
        let realm = try! Realm()
        // Add row via dictionary. Order is ignored.
        
        if (self.item != nil) {
            
            let updated_item = Inventory()
            
            updated_item.id = (item?.id)!
            updated_item.name = self.itemNameField.text!
            updated_item.item_description = self.descriptionField.text!
            updated_item.purchase_price = self.purchasePriceField.text!
            updated_item.purchased_date = self.purchaseDateField.text!
            if (self.imageView.image != nil) {
                let filename = "\(self.randomStringWithLength(10)).jpg"
                self.saveImage(self.imageView.image!, path: self.fileInDocumentsDirectory("\(filename)"))
                updated_item.photo = filename
            }
            
            try! realm.write {
                realm.add(updated_item, update: true)
            }
            item = updated_item
            print("item", item)
            performSegueWithIdentifier("showDetail", sender: self)
            
        } else {
            
            let item = Inventory()
            
            item.name = self.itemNameField.text!
            item.item_description = self.descriptionField.text!
            item.purchased_date = self.purchaseDateField.text!
            item.purchase_price = self.purchasePriceField.text!
            if (imageView.image != nil) {
                let filename = "\(randomStringWithLength(10)).jpg"
                saveImage(imageView.image!, path: fileInDocumentsDirectory("\(filename)"))
                item.photo = filename
            }
            
            realm.beginWrite()
            realm.add(item)
            
            do {
                
                self.room!.items.append(item)
                try realm.commitWrite()
                
                return_room = self.room
                
                if let navController = self.navigationController {
                    navController.popViewControllerAnimated(true)
                }
                
            } catch {
                print("could not add item")
            }
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail" {
            let itemDetailController:ItemDetailViewController = segue.destinationViewController as! ItemDetailViewController
            
            itemDetailController.room = self.room
            itemDetailController.item = self.item
        }
        
    }
    
}