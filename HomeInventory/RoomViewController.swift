//
//  RoomViewController.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/30/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import UIKit
import RealmSwift

class RoomViewController: UIViewController, UITextFieldDelegate {
    
    let realm = try! Realm()
    var notificationToken: NotificationToken?
    
    var room: Room? = nil
    
    @IBOutlet weak var roomNameField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    
    @IBAction func submitButton(sender: AnyObject) {
        
        // Get new realm and table since we are in a new thread
        let realm = try! Realm()
        let newRoom = Room()
        
        newRoom.name = self.roomNameField.text!
        newRoom.room_description = self.descriptionField.text!
        
        realm.beginWrite()
        realm.add(newRoom)
        
        do {
            try realm.commitWrite()
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }
            
        } catch {
            print("could not add room")
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        roomNameField.resignFirstResponder()
        return true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
