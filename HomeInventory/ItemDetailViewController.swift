//
//  showItemDetailController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 11/21/15.
//  Copyright © 2015 HashRocket. All rights reserved.
//

import UIKit
import RealmSwift

class ItemDetailViewController: UIViewController, UITextFieldDelegate {
    
    let realm = try! Realm()
    var notificationToken: NotificationToken?
    
    var room: Room? = nil
    var item: Inventory? = nil
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    
    @IBOutlet weak var itemPhoto: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        print("item: ", self.item)
        
        itemNameLabel.text = self.item?.name
        itemDescriptionLabel.text = self.item?.item_description
        
        let myImageName = self.item?.photo
        let imagePath = fileInDocumentsDirectory(myImageName!)
        
        if let loadedImage = loadImageFromPath(imagePath) {
            print(" Loaded Image: \(loadedImage)")
            itemPhoto.image = loadImageFromPath(imagePath)
        } else { print("some error message 2") }
        
        
        
        
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
        return fileURL.path!
        
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL
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
    
    func setupUI() {
        self.title = self.item?.name
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