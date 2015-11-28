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
            if array[activeRoom].items.count > 0 {
                print("room has items")
            } else {
                realm.beginWrite()
                realm.delete(array[activeRoom] as Object)
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
            inventoryController.room = array[activeRoom]
        } else if segue.identifier == "showAllInventory" {
            let inventoryController:InventoryTableViewController = segue.destinationViewController as! InventoryTableViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
