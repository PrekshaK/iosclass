

import UIKit


class DetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var detailItem : Stories!
    

    @IBOutlet weak var mImageView: UIImageView!
    
    @IBOutlet weak var hName: UILabel!
    @IBOutlet weak var mlocation: UILabel!

    @IBOutlet weak var mCharacteristics: UILabel!
    
    @IBOutlet weak var muploadedBy: UILabel!
    @IBOutlet weak var mStoryvalue: UILabel!

    @IBOutlet weak var mcommentView: UITextView!
    
    @IBOutlet weak var mtableView: UITableView!
    
    
    
    override func viewDidLoad() {
        

        
        
        
        
        hName.text = detailItem.mName;
        mlocation.text = detailItem.mLocation;
        mStoryvalue.text  = detailItem.mdescription;
        mImageView.image = detailItem.mImage;
//        muploadedBy.text = detailItem.myName;
        
    }
    
    

    @IBAction func mCallAction(sender: AnyObject) {
        
        let phone = "tel://" + String(detailItem.myName);
        let url:NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);
        
        
    }
    
    @IBAction func commentAction(sender: AnyObject) {
        self.mcommentView.becomeFirstResponder();
    }
    
    
    @IBAction func doneAction(sender: AnyObject) {
        
        let newComment = mcommentView.text;
        var commentsarray = detailItem.comments as! [String]
        commentsarray.append(newComment)
        detailItem.comments = commentsarray as! NSArray
        self.mtableView.reloadData();
        
        
    
        
        
        let someImageStore = KCSLinkedAppdataStore.storeWithOptions([
            
            KCSStoreKeyCollectionName: "Stories",
            KCSStoreKeyCollectionTemplateClass : Stories.self
            ])
        
        
        
        someImageStore.saveObject(detailItem, withCompletionBlock: {
            
            (objectsOrNil:[AnyObject]!, errorOrNil: NSError!) -> Void in
            print("Image Object Saved")
            
            
            
            if errorOrNil != nil {
                //save failed
                NSLog("Save failed, with error: %@", errorOrNil.localizedFailureReason!)
            } else {
                //save was successful
                NSLog("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
            }
            },
            withProgressBlock: nil
        )
        
        
    
    }
    
    

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let comments = detailItem.comments{
            return comments.count
            }
        
        else
        {
            return 0;
        }
            
        }
        
     
        


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let commentcell = UITableViewCell(style: .Value1, reuseIdentifier: "commentcell")
        commentcell.textLabel?.text = detailItem.comments![indexPath.row] as! String
        return commentcell
    }
    
    
    
    
    
    
    

}