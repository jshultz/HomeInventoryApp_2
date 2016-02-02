//
//  RoomsViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/30/15.
//  Copyright © 2016 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit
import RealmSwift


class BoxesTableViewController: UIViewController, UITableViewDelegate {
    
    var activeRoom = -1
    var box: Box? = nil
    var array = [Box]()
    var notificationToken: NotificationToken?
    
    let realm = try! Realm()
    
//    lazy var realm:Realm = {
//        return try! Realm()
//    }()
    
    @IBOutlet var boxesTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        array = Array(realm.objects(Box.self))
        
        setupUI()
        // Set realm notification block
        notificationToken = realm.addNotificationBlock { [unowned self] note, realm in
            // TODO: you are going to need to update array
            self.array = Array(realm.objects(Box.self))
            self.boxesTable.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    func setupUI() {
        
        if (box != nil) {
            self.title = box?.name
        } else {
            self.title = "Boxes"
        }
        
        
        
    }
    
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
        
        cell.textLabel?.text = object.name
        //        cell.detailTextLabel?.text = object.date.description
        
        let item = realm.objects(Box).filter(NSPredicate(format: "id = %@", "\(object.id)")).first
        
        let myImageName = item!.photo
        shortDescription.text = item!.box_description.trunc(90)
        
        let imagePath = fileInDocumentsDirectory(myImageName)
        
        if let loadedImage = loadImageFromPath(imagePath) {
            if item!.photo != "" {
                imageView.image = loadImageFromPath(imagePath)
            }
        } else { print("some error message 2") }
        
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        activeRoom = indexPath.row
        return indexPath
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
    
    // Override to support editing the table view.
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // Delete the row from the data source
////            print("indexPath.row: ", array[indexPath.row])
//            
//            
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newPlace" {
            
        } else if segue.identifier == "showBoxInventory" {
            let cell = sender as! UITableViewCell
            let indexPath = boxesTable.indexPathForCell(cell)
            let inventoryController:InventoryTableViewController = segue.destinationViewController as! InventoryTableViewController
            inventoryController.box = array[indexPath!.row]
//            inventoryController.room = array[indexPath!.row]
        } else if segue.identifier == "showAllInventory" {
            let inventoryController:InventoryTableViewController = segue.destinationViewController as! InventoryTableViewController
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
