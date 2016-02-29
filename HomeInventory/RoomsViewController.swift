//
//  RoomsViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/30/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit
import CoreData


class RoomsViewController: UIViewController, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    var activeRoom = -1
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    @IBOutlet weak var roomsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Retrieve Rooms
    
    let sortBy = ""
    
    func getFetchedResultController(sortBy:String) -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: roomFetchRequest(sortBy), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func roomFetchRequest(sortBy:String) -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Rooms")
        
        var sortDescriptor = NSSortDescriptor()
        if (sortBy == "name") {
            sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        } else {
            sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        }
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func setupUI() {
        
        self.roomsTable.backgroundColor = UIColor(red: 0.1176, green: 0.6902, blue: 1, alpha: 1.0) /* #1eb0ff */
        self.view?.backgroundColor = UIColor(red: 0.1176, green: 0.6902, blue: 1, alpha: 1.0) /* #1eb0ff */
        self.roomsTable.separatorStyle = UITableViewCellSeparatorStyle.None
        
        fetchedResultController = getFetchedResultController("name")
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        } catch _ {
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = fetchedResultController.sections?.count
        return numberOfSections!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        

        cell.backgroundColor = UIColor(red: 0.0627, green: 0.3882, blue: 0.9098, alpha: 1.0) /* #1063e8 */
        
        let object = fetchedResultController.objectAtIndexPath(indexPath) as! Rooms
        
        cell.textLabel?.text = object.valueForKey("name") as? String
        let Title = cell.viewWithTag(10) as! UILabel
        Title.textColor = UIColor.whiteColor()
        
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
            
            let managedObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as! NSManagedObject
            managedObjectContext.deleteObject(managedObject)
            do {
                try managedObjectContext.save()
            } catch _ {
            }
            
//            if array[indexPath.row].items.count > 0 {
//                let alertController = UIAlertController(title: "Can't Delete the Room", message:
//                    "You can't delete a room that still has items.", preferredStyle: UIAlertControllerStyle.Alert)
//                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//                
//                self.presentViewController(alertController, animated: true, completion: nil)
//            } else {
//                print("array[indexPath.row]:", array[indexPath.row])
//                realm.beginWrite()
//                realm.delete(array[indexPath.row] as Object)
//                try! realm.commitWrite()
//            }
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
            let room:Rooms = fetchedResultController.objectAtIndexPath(indexPath!) as! Rooms
            inventoryController.room = room
            
        } else if segue.identifier == "showAllInventory" {
            
            let inventoryController:InventoryTableViewController = segue.destinationViewController as! InventoryTableViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
