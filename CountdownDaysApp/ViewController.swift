//
//  ViewController.swift
//  CountdownDaysApp
//
//  Created by JScharm on 12/15/16.
//  Copyright © 2016 JScharm. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!

    var items : [CountdownClass] = []
    
    let dateFormatter = DateFormatter()
    let currentDate = NSDate()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        editButton.tag = 0
        myTableView.allowsSelection = true
        
        dateFormatter.dateStyle = DateFormatter.Style.long
        let convertedDate = dateFormatter.string(from: currentDate as Date)
        dateLabel.text = String(convertedDate)
        
        load()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        load()
    }

    @IBAction func editButtonTapped(_ sender: Any)
    {
        if editButton.tag == 0
        {
            myTableView.isEditing = true
            editButton.tag = 1
        }
        else
        {
            myTableView.isEditing = false
            editButton.tag = 0
        }

    }
    
    @IBAction func addButtonTapped(_ sender: Any)
    {
        let myAlert = UIAlertController(title: "Add Event", message: nil, preferredStyle: .alert)
        myAlert.addTextField { (nameTextField) -> Void in
            nameTextField.placeholder = "Add Event Name Here"
        }
        myAlert.addTextField { (daysTillEventTextField) -> Void in
            daysTillEventTextField.placeholder = "Add Days Till Event Here"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        myAlert.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (addAction) -> Void in
            
        let nameTF = myAlert.textFields![0] as UITextField
        let daysTextField = myAlert.textFields![1] as UITextField
            
        self.items.append(CountdownClass(name: nameTF.text!, days: daysTextField.text!))
            
        self.myTableView.reloadData()
    }
        myAlert.addAction(addAction)
        self.present(myAlert, animated: true, completion: nil)

        print(self.items)
        
        save()
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let myCell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        myCell.textLabel!.text = items[indexPath.row].name
        myCell.detailTextLabel?.text = items[indexPath.row].days
        return myCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            items.remove(at: indexPath.row)
            myTableView.reloadData()
        }
        
        save()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = items[sourceIndexPath.row]
        items.remove(at: sourceIndexPath.row)
        items.insert(item, at: destinationIndexPath.row)
        
        save()
    }
    
    func save()
    {
        //NSKeyedArchiver, convert our array into a data object
       let savedData = NSKeyedArchiver.archivedData(withRootObject: items)
        
        let defaults = UserDefaults.standard
       defaults.set(savedData, forKey: "items")
        
    }
    
    func load()
    {
        let defaults = UserDefaults.standard
        // pulls out data from disk
        if let savedCountdowns = defaults.object(forKey: "items") as? Data
        {
            // converts data back to an object
            items = NSKeyedUnarchiver.unarchiveObject(with: savedCountdowns) as! [CountdownClass]
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let detailView = segue.destination as! DetailViewController
        let selectedRow = myTableView.indexPathForSelectedRow?.row
        detailView.detailItem = items[selectedRow!]
    }
    
}

