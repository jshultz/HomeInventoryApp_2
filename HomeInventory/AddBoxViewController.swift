//
//  AddBoxViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 1/16/16.
//  Copyright © 2016 HashRocket. All rights reserved.
//

import UIKit
import RealmSwift
import Photos
import PhotosUI

class AddBoxViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    var room: Room? = nil
    
    var box: Box? = nil
    
    var return_room: Room? = nil
    
    var notificationToken: NotificationToken?
    
    var imageFilePath:String = ""
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func addPhoto(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var boxNameField: UITextField!
    
    @IBOutlet weak var boxDescriptionField: UITextField!
    
    @IBAction func cancelButton(sender: AnyObject) {
        if (box != nil) {
            performSegueWithIdentifier("showDetail", sender: self)
        } else {
            performSegueWithIdentifier("showInventory", sender: self)
        }
    }
    
    
    @IBAction func saveBox(sender: AnyObject) {
        let realm = try! Realm()
        
        if (self.box != nil) {
            
            let updated_item = Box()
            
            updated_item.id = (box?.id)!
            updated_item.name = self.boxNameField.text!
            updated_item.box_description = self.boxDescriptionField.text!
            if (self.imageView.image != nil) {
                let filename = "\(self.randomStringWithLength(10)).jpg"
                self.saveImage(self.imageView.image!, path: self.fileInDocumentsDirectory("\(filename)"))
                updated_item.photo = filename
            }
            
            try! realm.write {
                realm.add(updated_item, update: true)
            }
            
            box = updated_item
            
            performSegueWithIdentifier("showBox", sender: self)
            
        } else {
            let newBox = Box()
            
            newBox.name = self.boxNameField.text!
            newBox.box_description = self.boxDescriptionField.text!
            if (imageView.image != nil) {
                let filename = "\(randomStringWithLength(10)).jpg"
                saveImage(imageView.image!, path: fileInDocumentsDirectory("\(filename)"))
                newBox.photo = filename
            }
            
            realm.beginWrite()
            realm.add(newBox)
            
            do {
                if (room != nil) {
                    self.room?.boxes.append(newBox)
                    return_room = self.room
                }
                try realm.commitWrite()
                if let navController = self.navigationController {
                    navController.popViewControllerAnimated(true)
                }
                
            } catch {
                print("could not add box")
            }
        }
        
        performSegueWithIdentifier("showRooms", sender: self)
    }
    
    func setupUI() {
        if (box != nil) {
            self.title = box?.name
            boxNameField.text = box?.name
            boxDescriptionField.text = box?.box_description
            
            let myImageName = box?.photo
            
            let imagePath = fileInDocumentsDirectory(myImageName!)
            
            if let loadedImage = loadImageFromPath(imagePath) {
                if self.box?.photo != "" {
                    imageView.image = loadImageFromPath(imagePath)
                }
            } else { print("some error message 2") }
            
        } else {
            if (room != nil) {
                self.title = "\(room!.name): Add Box"
            } else {
                self.title = "Add Box"
            }
            
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
    
    func saveImage (image: UIImage, path: String ) -> String{
        
        let pngImageData = UIImagePNGRepresentation(image)
        //let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        let result = pngImageData!.writeToFile(path, atomically: true)
        return path
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
