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
    
    lazy var realm:Realm = {
        return try! Realm()
    }()
    
    @IBOutlet var boxesTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        array = Array(realm.objects(Box.self))
        
        setupUI()
        // Set realm notification block
        notificationToken = realm.addNotificationBlock { [unowned self] note, realm in
            // TODO: you are going to need to update array
            self.boxesTable.reloadData()
        }
    }
    
    func setupUI() {
        
        self.title = box?.name
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let object = array[indexPath.row]
        cell.textLabel?.text = object.name
        //        cell.detailTextLabel?.text = object.date.description
        
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        activeRoom = indexPath.row
        return indexPath
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            print("indexPath.row: ", array[indexPath.row])
            
            if array[indexPath.row].items.count > 0 {
                let alertController = UIAlertController(title: "Can't Delete the Room", message:
                    "You can't delete a room that still has items.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                print("array[indexPath.row]:", array[indexPath.row])
                realm.beginWrite()
                realm.delete(array[indexPath.row] as Object)
                try! realm.commitWrite()
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newPlace" {
            
        } else if segue.identifier == "showInventory" {
            print("in showInventory")
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
