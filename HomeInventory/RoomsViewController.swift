//
//  RoomsViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/30/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit
import RealmSwift



class RoomsViewController: UIViewController, UITableViewDelegate {
    
    var activeRoom = -1
    var room: Room? = nil
    let realm = try! Realm()
    let array = try! Realm().objects(Room)
    var notificationToken: NotificationToken?
    
    @IBOutlet weak var roomsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Set realm notification block
        notificationToken = realm.addNotificationBlock { [unowned self] note, realm in
            self.roomsTable.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        
        self.title = room?.name
        self.roomsTable.backgroundColor = UIColor(red: 0.1176, green: 0.6902, blue: 1, alpha: 1.0) /* #1eb0ff */
        self.roomsTable.separatorStyle = UITableViewCellSeparatorStyle.None

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        

        cell.backgroundColor = UIColor(red: 0.0627, green: 0.3882, blue: 0.9098, alpha: 1.0) /* #1063e8 */
        
        let object = array[indexPath.row]
        cell.textLabel?.text = object.name
        let Title = cell.viewWithTag(10) as! UILabel
        Title.textColor = UIColor.whiteColor()
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
            let cell = sender as! UITableViewCell
            let indexPath = roomsTable.indexPathForCell(cell)
            let inventoryController:InventoryTableViewController = segue.destinationViewController as! InventoryTableViewController
            inventoryController.room = array[indexPath!.row]
        } else if segue.identifier == "showAllInventory" {
            let inventoryController:InventoryTableViewController = segue.destinationViewController as! InventoryTableViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
