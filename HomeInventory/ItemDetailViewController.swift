//
//  showItemDetailController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 11/21/15.
//  Copyright © 2015 HashRocket. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailViewController: UIViewController, UITextFieldDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var room: Rooms? = nil
    var item: Inventory? = nil
    
    @IBOutlet weak var itemDescriptionLabel: UITextView!
    
    @IBOutlet weak var itemPhoto: UIImageView!
    
    @IBOutlet weak var itemPurchasedLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        itemDescriptionLabel.text = self.item?.item_description
        
        let purchaseTitle:String = ((item?.name) != nil) ? String(item!.name) : "An unknown item"
        
        let purchaseDate:String = ((item?.purchased_date) != nil) ? String(item!.purchased_date) : "an unkown"
        
        let purchasePrice:String = ((item?.purchase_price) != nil) ? String(item!.purchase_price) : "an unknown"
        
        self.itemPurchasedLabel.text = "\(purchaseTitle) was purchased on \(purchaseDate) for \(purchasePrice)."
        
        let myImageName = self.item?.photo
        let imagePath = fileInDocumentsDirectory(myImageName!)
        
        if let _ = loadImageFromPath(imagePath) {
            if self.item?.photo != "" {
                itemPhoto.image = loadImageFromPath(imagePath)
            }
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
        
        self.view?.backgroundColor = UIColor(red: 0.1176, green: 0.6902, blue: 1, alpha: 1.0) /* #1eb0ff */
        self.itemPurchasedLabel.textColor = UIColor.whiteColor()
        self.itemDescriptionLabel.textColor = UIColor.whiteColor()
        self.itemPurchasedLabel.backgroundColor = UIColor(red: 0.1176, green: 0.6902, blue: 1, alpha: 1.0) /* #1eb0ff */
        self.itemDescriptionLabel.backgroundColor = UIColor(red: 0.1176, green: 0.6902, blue: 1, alpha: 1.0) /* #1eb0ff */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editItem" {
            let addItemController:AddItemViewController = segue.destinationViewController as! AddItemViewController
            
            addItemController.item = self.item
        }
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }

    
}