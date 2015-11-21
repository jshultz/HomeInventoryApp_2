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
            print("hello? ", self.room)
            self.array = Array(self.room!.items)
            self.inventoryTable.reloadData()
        }
        
        inventoryTable.reloadData()
    }
    
    func setupUI() {
        self.title = room?.name
        array = try! Array(Realm().objects(Room).filter(NSPredicate(format: "id = %@", "\(room!.id)")).first!.items)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! InventoryTableViewCell
        let object = array[indexPath.row]
        cell.textLabel?.text = object.name
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        activeInventory = indexPath.row
        return indexPath
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
        }
        
        
    }


}
