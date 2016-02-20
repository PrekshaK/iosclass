//
//  DetailViewController.swift
//  newtable
//
//  Created by Preksha Koirala on 2/20/16.
//  Copyright © 2016 Preksha Koirala. All rights reserved.
//
import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var myTextView: UITextView!
    var viewController:ViewController?
    var masterView:ViewController?
    
    
//    var detailItem: AnyObject? {
//        didSet {
//            // Update the view.
//            self.configureView()
//        }
//    }
//    
    
    func configureView() {
        // Update the user interface for the detail item.
        if words.count == 0{
            return
        }
        
        if let label = self.myTextView {
            label.text = words[currentIndex]
            if label.text == BLANK_NOTE{
                label.text=""
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, \
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textViewDidChange(textView: UITextView) {
        
    
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
       
        
        if myTextView.text == ""{
            words.append(BLANK_NOTE);
            
        }
        else{
            words.append(myTextView.text);
        }
        saveAndUpdate()
    }
    
    
    func saveAndUpdate(){
        masterView?.save()
        masterView?.tableView.reloadData()
        
    }

    
    
}

