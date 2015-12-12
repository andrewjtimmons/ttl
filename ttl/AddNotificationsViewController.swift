//
//  AddNotificationsViewController.swift
//  ttl
//

import UIKit

class AddNotificationsViewController: UIViewController {
    let prefs = NSUserDefaults.standardUserDefaults()
    var txtView = UITextView(frame: CGRectZero)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        txtView = buildTxtView("Loading \n\n Take a few deep breaths and check back in a moment")
        
        self.view.addSubview(txtView)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
    }
    
    func buildTxtView(text: String) -> UITextView {
        //builds textview and text to tell you how long you lived
        
        let txtView = UITextView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        txtView.userInteractionEnabled = false
        txtView.textAlignment = NSTextAlignment.Center
        txtView.font =  UIFont(name: "helvetica", size: self.view.frame.size.height/18)
        txtView.text = text
        
        //code to make the text view frame the exact size of the content.  From http://stackoverflow.com/questions/50467/how-do-i-size-a-uitextview-to-its-content
        let fixedWidth = txtView.frame.size.width
        txtView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = txtView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = txtView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        txtView.frame = newFrame;
        
        //set center to middle of screen
        txtView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)
        return txtView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        //if no notification has been set then add one.

        if (prefs.objectForKey("notificationSet") == nil){
            addNotifications(365)
        }
    }
    
    func addNotifications(numDays:Int) {
        //let today = NSDate()
        let userTimeToLive = TimeToLive()
        for day in 1..<numDays+1{
            let (messageBody, messageFireDate) = userTimeToLive.buildTxtForFutureDate(NSDate(), daysInFuture: day)
            let localNotification = UILocalNotification()
            localNotification.fireDate = messageFireDate
            localNotification.alertBody = messageBody
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            print(messageFireDate)
        }
        print("done")
        self.prefs.setObject(true, forKey:"notificationSet")
        self.performSegueWithIdentifier("notificationsSetSegue", sender: self)
        
    }
    
}
