//
//  InventoryTableViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/30/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit
import RealmSwift

class InventoryTableViewController: UIViewController, UITableViewDelegate {
    var activeInventory = -1
    var activeRoom = -1
    var room: Room? = nil
    var array = []
    let realm = try! Realm()
    var notificationToken: NotificationToken?
    
    @IBOutlet weak var inventoryTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Set realm notification block
        notificationToken = realm.addNotificationBlock { [unowned self] note, realm in
            
            if ((self.room?.items) != nil) {
                self.array = Array(self.room!.items)
            }
            
            self.inventoryTable.reloadData()
        }
        
        inventoryTable.reloadData()
    }
    
    @IBAction func addThingToRoom(sender: AnyObject) {
        
        showAlert("Add a Thing", errorMessage: "Add an Item (single thing) or a Box (box, dresser, etc.")
        
    }
    
    func showAlert(errorTitle:String, errorMessage:String) {
        print("in the alert")
        let alert = UIAlertController(title: "\(errorTitle)", message: "\(errorMessage)", preferredStyle: .Alert) // 1
        let firstAction = UIAlertAction(title: "Item", style: .Default) { (alert: UIAlertAction!) -> Void in
            NSLog("You pressed button one")
            self.performSegueWithIdentifier("addItem", sender: self)
            
        } // 2
        
        let secondAction = UIAlertAction(title: "Box", style: .Default) { (alert: UIAlertAction!) -> Void in
            NSLog("You pressed button two")
            self.performSegueWithIdentifier("addBox", sender: self)
        } // 3
        
        alert.addAction(firstAction) // 4
        alert.addAction(secondAction) // 5
        presentViewController(alert, animated: true, completion:nil) // 6
    }
    
    
    func setupUI() {
        if (room != nil) {
            self.title = room?.name
            array = try! Array(Realm().objects(Room).filter(NSPredicate(format: "id = %@", "\(room!.id)")).first!.items)
        } else {
            self.title = "All Your Stuff"
            array = try! Array(Realm().objects(Inventory))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    // MARK: - Table view data source

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let object = array[indexPath.row]
        
        let imageView = cell.viewWithTag(10) as! UIImageView
        let label = cell.viewWithTag(20) as! UILabel
        label.text = object.name
        
        let shortDescription = cell.viewWithTag(30) as! UILabel
        
        
        let item = realm.objects(Inventory).filter(NSPredicate(format: "id = %@", "\(object.id)")).first
        
        let myImageName = item!.photo
        shortDescription.text = item!.item_description.trunc(90)
        
        let imagePath = fileInDocumentsDirectory(myImageName)
        
        if let loadedImage = loadImageFromPath(imagePath) {
            if item!.photo != "" {
                imageView.image = loadImageFromPath(imagePath)
            }
        } else { print("some error message 2") }
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        print("indexPath: ", indexPath)
        activeInventory = indexPath.row
        return indexPath
    }
    

    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            realm.beginWrite()
            realm.delete(array[indexPath.row] as! Object)
            try! realm.commitWrite()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "newPlace" {
            
        } else if segue.identifier == "addItem" {
            
            let addItemController:AddItemViewController = segue.destinationViewController as! AddItemViewController
            
            addItemController.room = self.room
        } else if segue.identifier == "addBox" {
            
            let addBoxController:AddBoxViewController = segue.destinationViewController as! AddBoxViewController
            
            addBoxController.room = self.room
        } else if segue.identifier == "editRoom" {
            
            let editRoomController:EditRoomViewController = segue.destinationViewController as! EditRoomViewController
            
            editRoomController.room = self.room
            
        } else if segue.identifier == "showItem" {
            
            let itemDetailController:ItemDetailViewController = segue.destinationViewController as! ItemDetailViewController
            
            itemDetailController.room = self.room
            print("activeInventory: ", activeInventory)
            itemDetailController.item = Inventory(value: array[activeInventory])
        }
        
        
    }


}
