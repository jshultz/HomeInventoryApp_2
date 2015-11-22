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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! InventoryTableViewCell
        let object = array[indexPath.row]
        cell.textLabel?.text = object.name
        
        let item = realm.objects(Inventory).filter(NSPredicate(format: "id = %@", "\(object.id)")).first
        
        let myImageName = item!.photo
        let imagePath = fileInDocumentsDirectory(myImageName)
        
        if let loadedImage = loadImageFromPath(imagePath) {
            if item!.photo != "" {
                cell.photoView.image = loadImageFromPath(imagePath)
            }
        } else { print("some error message 2") }
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        print("indexPath: ", indexPath)
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
        } else if segue.identifier == "showItem" {
            
            let itemDetailController:ItemDetailViewController = segue.destinationViewController as! ItemDetailViewController
            
            itemDetailController.room = self.room
            print("activeInventory: ", activeInventory)
            itemDetailController.item = Inventory(value: array[activeInventory])
        }
        
        
    }


}
