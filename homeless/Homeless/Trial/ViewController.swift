

import UIKit


var Username: String?

class ViewController: UIViewController {
    
    
    @IBOutlet weak var UserNameValue: UITextField!
    
    @IBOutlet weak var PasswordValue: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        UserNameValue.becomeFirstResponder()
        
        
        KCSClient.sharedClient().initializeKinveyServiceForAppKey(
            "kid_Zy-vmArueZ",
            withAppSecret: "aebce3d6402742b4b2c18ef081ca7580",
            usingOptions: nil
        )
        
        KCSPing.pingKinveyWithBlock { (result: KCSPingResult!) -> Void in
            if result.pingWasSuccessful {
                NSLog("Kinvey Ping Success")
                //self.save()
            } else {
                NSLog("Kinvey Ping Failed")
            }
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //if active user exists then just go to the home page
        
        
        if KCSUser.activeUser() != nil {
            print("performing segue")
            self.performSegueWithIdentifier("homePage", sender: self)
        }
        
    }
    
    func createNewUser(){
        // Create a new user with the username 'kinvey' and the password '12345'
        if KCSUser.activeUser() == nil {
            KCSUser.userWithUsername(
                UserNameValue.text,
                password: PasswordValue.text,
                fieldsAndValues: nil,
                withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                    if errorOrNil == nil {
                        //user is created
                        let message = "Successful"
                        let alert = UIAlertView(
                            title: NSLocalizedString("Successfully created account. Now you can log in", comment: "Good Job"),
                            message: message,
                            delegate: nil,
                            cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                        )
                        alert.show()
                    } else {
                        //there was an error with the create
                        let message = errorOrNil.localizedDescription
                        let alert = UIAlertView(
                            title: NSLocalizedString("Problem with creating new account", comment: "Sign up failed"),
                            message: message,
                            delegate: nil,
                            cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                        )
                        alert.show()
                        
                        
                    }
                }
            )
            
        }
        else{
            print("already created")
        }
    }
//    
//    func save(){
//        let store = KCSAppdataStore.storeWithOptions([
//            KCSStoreKeyCollectionName : "CLoths",
//            KCSStoreKeyCollectionTemplateClass : Cloths.self
//            ])
//        
//        let event = Cloths()
//        event.mname = "Launch Party"
//        event.location = "Kinvey HQ"
//        event.date = NSDate(timeIntervalSince1970: 1352149171) //sample date
//        store.saveObject(
//            event,
//            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
//                if errorOrNil != nil {
//                    //save failed
//                    NSLog("Save failed, with error: %@", errorOrNil.localizedFailureReason!)
//                } else {
//                    //save was successful
//                    NSLog("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
//                }
//            },
//            withProgressBlock: nil
//        )
//        
//    }
    
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func AddNewUser(sender: AnyObject) {
        //call function createnewuser to create the new user as provided in the fields
        createNewUser()
    }
    
    @IBAction func LoginUser(sender: AnyObject) {
        
        
        if KCSUser.activeUser() == nil {
        KCSUser.loginWithUsername(
            UserNameValue.text,
            password: PasswordValue.text,
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    //the log-in was successful and the user is now the active user and credentials saved
                    //hide log-in view and show main app content
                    self.performSegueWithIdentifier("homePage", sender: self)
                } else {
                    //there was an error with the update save
                    let message = errorOrNil.localizedDescription
                    let alert = UIAlertView(
                        title: NSLocalizedString("Account does not exist", comment: "Sign account failed"),
                        message: message,
                        delegate: nil,
                        cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                    )
                    alert.show()
                }
            }
        )
        }
        else{
            performSegueWithIdentifier("homePage", sender: self)
        }
    }
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
        KCSUser.activeUser().logout()
    }
    
    
}

