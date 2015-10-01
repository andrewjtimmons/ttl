//
//  ShowTimeToLiveViewController.swift
//  ttl
//
//  Created by andrew timmons on 8/20/15.
//  Copyright (c) 2015 andy. All rights reserved.
//

import UIKit

class ShowTimeToLiveViewController: UIViewController {
   
    let prefs = NSUserDefaults.standardUserDefaults()
    var asdf:Int32 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.view.backgroundColor = UIColor.whiteColor()
        
        let userTimeToLive = TimeToLive()
        var txtView = buildTxtView(userTimeToLive.buildTxtForToday())
        self.view.addSubview(txtView)
    }
    
    override func viewDidAppear(animated: Bool) {
        //if no notification has been set then add one
        
        if (prefs.objectForKey("notificationSet") == nil){
            addNotifications(365)
        }
    }
    
    func buildTxtView(text: String) -> UITextView {
        //builds textview and text to tell you how long you lived
        
        var navHeight = self.navigationController!.navigationBar.frame.size.height

        var txtView = UITextView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        txtView.userInteractionEnabled = false
        txtView.textAlignment = NSTextAlignment.Center
        txtView.font =  UIFont(name: "helvetica", size: self.view.frame.size.height/18)
        txtView.text = text

        //code to make the text view frame the exact size of the content.  From http://stackoverflow.com/questions/50467/how-do-i-size-a-uitextview-to-its-content
        let fixedWidth = txtView.frame.size.width
        txtView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = txtView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = txtView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height + 2*navHeight)
        txtView.frame = newFrame;
        
        //set center to middle of screen
        txtView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)
        return txtView
    }
    
    func addNotifications(numDays:Int) {
        let today = NSDate()
        let userTimeToLive = TimeToLive()

        
        for day in 1..<numDays+1{
            let (messageBody, messageFireDate) = userTimeToLive.buildTxtForFutureDate(NSDate(), daysInFuture: day)
            var localNotification = UILocalNotification()
            localNotification.fireDate = messageFireDate
            localNotification.alertBody = messageBody
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        }
        println("done")
        //prefs.setObject(true, forKey:"notificationSet")

    
    
    }
    
}
