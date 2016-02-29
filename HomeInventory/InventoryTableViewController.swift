//
//  InventoryTableViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/30/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit
import CoreData

class InventoryTableViewController: UIViewController, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    var activeInventory = -1
    var activeRoom = -1
    var room: Rooms? = nil
    var array = []
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    @IBOutlet weak var inventoryTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
                
        inventoryTable.reloadData()
    }
    
    // MARK:- Retrieve Room Inventory OR All Inventory
    
    let sortBy = ""
    
    func getFetchedResultController(sortBy:String) -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: legoSetFetchRequest(sortBy), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func legoSetFetchRequest(sortBy:String) -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "LegoSets")
        
        var sortDescriptor = NSSortDescriptor()
        if (sortBy == "description") {
            sortDescriptor = NSSortDescriptor(key: "descr", ascending: true)
        } else {
            sortDescriptor = NSSortDescriptor(key: "set_id", ascending: true)
        }
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func setupUI() {
        if (room != nil) {
            self.title = room?.name
//            array = try! Array(Realm().objects(Room).filter(NSPredicate(format: "id = %@", "\(room!.id)")).first!.items)
        } else {
            self.title = "All Your Stuff"
//            array = try! Array(Realm().objects(Inventory))
        }
        
        self.inventoryTable.backgroundColor = UIColor(red: 0.1176, green: 0.6902, blue: 1, alpha: 1.0) /* #1eb0ff */
        self.inventoryTable.separatorStyle = UITableViewCellSeparatorStyle.None
        
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
        let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let object = array[indexPath.row]
        
        let imageView = cell.viewWithTag(10) as! UIImageView
        let label = cell.viewWithTag(20) as! UILabel
        label.text = object.name
        
        label.textColor = UIColor.whiteColor()
        
        let Title = cell.viewWithTag(30) as! UILabel
        Title.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor(red: 0.0627, green: 0.3882, blue: 0.9098, alpha: 1.0) /* #1063e8 */
        
        let shortDescription = cell.viewWithTag(30) as! UILabel
        
//        let item = realm.objects(Inventory).filter(NSPredicate(format: "id = %@", "\(object.id)")).first
//        
//        let myImageName = item!.photo
//        shortDescription.text = item!.item_description.trunc(90)
//        
//        let imagePath = fileInDocumentsDirectory(myImageName)
//        
//        if let loadedImage = loadImageFromPath(imagePath) {
//            if item!.photo != "" {
//                imageView.image = loadImageFromPath(imagePath)
//            }
//        } else { print("some error message 2") }
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
            let managedObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as! NSManagedObject
            managedObjectContext.deleteObject(managedObject)
            do {
                try managedObjectContext.save()
            } catch _ {
            }
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
        } else if segue.identifier == "editRoom" {
            
            let editRoomController:EditRoomViewController = segue.destinationViewController as! EditRoomViewController
            
            editRoomController.room = self.room
            
        } else if segue.identifier == "showItem" {
            
            let itemDetailController:ItemDetailViewController = segue.destinationViewController as! ItemDetailViewController
            
            itemDetailController.room = self.room
            print("activeInventory: ", activeInventory)
//            itemDetailController.item = Inventory(value: array[activeInventory])
        }
        
        
    }


}
