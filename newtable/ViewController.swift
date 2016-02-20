//
//  ViewController.swift
//  newtable
//
//  Created by Preksha Koirala on 2/4/16.
//  Copyright © 2016 Preksha Koirala. All rights reserved.
//

import UIKit

 var words:[String] = ["Hello", "Preksha", "How", "Are", "You"]

   var currentIndex:Int = 0;

let BLANK_NOTE:String = "(New Note)"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   
    
 
    
    var detailViewController:DetailViewController?

    @IBOutlet weak var editToogleButton: UIBarButtonItem!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        save()
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionEditToogle(sender: UIBarButtonItem) {
        
        tableView.setEditing(!tableView.editing, animated:true)

            sender.title = tableView.editing ? "Stop Editing": "Edit"

        
        
    }
    
    
    func save()
    {
        
        let indexPath = NSIndexPath(forRow: words.count-1, inSection: 0)
        
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        
    }

    
    
    
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if (tableView.editing){
            return .Delete
        }
        return .None
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete{
            words.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }else if (editingStyle == .Insert){
             //Add insert code
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "id")
        
        cell.textLabel?.text = words[indexPath.row]
        return cell
        
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    
 

}

