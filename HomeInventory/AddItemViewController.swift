//
//  AddItemViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/31/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
import CoreData

class AddItemViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var room: Rooms? = nil
    
    var item: Inventory? = nil
    
    var return_room: Rooms? = nil
        
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
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        if (item != nil) {
            performSegueWithIdentifier("showDetail", sender: self)
        } else {
            performSegueWithIdentifier("showInventory", sender: self)
        }
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
            purchaseDateField.text = String(item?.purchased_date)
            purchasePriceField.text = String(item?.purchase_price)
            
            let myImageName = item?.photo
            let imagePath = fileInDocumentsDirectory(myImageName!)
            
            if let _ = loadImageFromPath(imagePath) {
                if self.item?.photo != "" {
                    imageView.image = loadImageFromPath(imagePath)
                }
            } else { print("some error message 2") }
            
        } else {
            self.title = room?.name
        }
        
        self.view?.backgroundColor = UIColor(red: 0.1176, green: 0.6902, blue: 1, alpha: 1.0) /* #1eb0ff */

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
    
    func loadImageFromPath(path: String) -> UIImage? {
        var image = UIImage()
        let data = NSData(contentsOfFile: path)
        if (data != nil) {
            image = UIImage(data: data!)!
        } else {
        }
        return image
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
        _ = pngImageData!.writeToFile(path, atomically: true)
        return path
        
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        // Add row via dictionary. Order is ignored.
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let date = dateFormatter.dateFromString(self.purchaseDateField.text!)
        
        // create an app delegate variable
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // context is a handler for us to be able to access the database. this allows us to access the CoreData database.
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        
        // see if we are updating a LegoSet or not?
        let request = NSFetchRequest(entityName: "Inventory")
        
        // if we want to search for something in particular we can use predicates:
        request.predicate = NSPredicate(format: "id = %@", self.item!.id!) // search for users where username = Steve
        
        // by default, if we do a request and get some data back it returns false for the actual data. if we want to get data back and see it, then we need to set this as false.
        request.returnsObjectsAsFaults = false
        
        do {
            // save the results of our fetch request to a variable.
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    result.setValue(item?.id, forKey: "id")
                    result.setValue(self.itemNameField.text!, forKey: "name")
                    result.setValue(self.descriptionField.text!, forKey: "item_description")
                    result.setValue(self.purchasePriceField.text!, forKey: "purchase_price")
                    result.setValue(date, forKey: "purchased_date")
                    
                    if (self.imageView.image != nil) {
                        let filename = "\(self.randomStringWithLength(10)).jpg"
                        self.saveImage(self.imageView.image!, path: self.fileInDocumentsDirectory("\(filename)"))
                        result.setValue(filename, forKey: "photo")
                    }
                }
                
            } else {
                let newItem = NSEntityDescription.insertNewObjectForEntityForName("Inventory", inManagedObjectContext: context)
                
                newItem.setValue(item?.id, forKey: "id")
                newItem.setValue(self.itemNameField.text!, forKey: "name")
                newItem.setValue(self.descriptionField.text!, forKey: "item_description")
                newItem.setValue(self.purchasePriceField.text!, forKey: "purchase_price")
                newItem.setValue(date, forKey: "purchased_date")
                
                if (self.imageView.image != nil) {
                    let filename = "\(self.randomStringWithLength(10)).jpg"
                    self.saveImage(self.imageView.image!, path: self.fileInDocumentsDirectory("\(filename)"))
                    newItem.setValue(filename, forKey: "photo")
                }
            }
        } catch {
            
        }
        
        do {
            // save the context.
            try context.save()
            performSegueWithIdentifier("showDetail", sender: self)
        } catch {
            print("There was a problem")
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