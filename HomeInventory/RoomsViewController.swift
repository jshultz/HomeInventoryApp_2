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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RoomsTableViewCell
        
        let object = array[indexPath.row]
        cell.textLabel?.text = object.name
        //        cell.detailTextLabel?.text = object.date.description
        
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        activeRoom = indexPath.row
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newPlace" {

        } else if segue.identifier == "showInventory" {
            let cell = sender as! UITableViewCell
            let indexPath = roomsTable.indexPathForCell(cell)
            let inventoryController:InventoryTableViewController = segue.destinationViewController as! InventoryTableViewController
            inventoryController.room = array[activeRoom]
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

}
