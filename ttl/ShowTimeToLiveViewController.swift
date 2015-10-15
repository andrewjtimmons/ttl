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
    var txtView = UITextView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.view.backgroundColor = UIColor.whiteColor()
        
        var text = getUserText()
        txtView = buildTxtView(text)
        
        self.view.addSubview(txtView)
        
        //listener to refresh view when returning from background state.
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(
            self,
            selector: "updateView:",
            name:UIApplicationWillEnterForegroundNotification,
            object: nil
        )
    }
    
    override func viewDidAppear(animated: Bool) {
        //if no notification has been set then add one.
        if (prefs.objectForKey("notificationSet") == nil){
            addNotifications(365)
        }
    }
    
    func getUserText() -> String {
        //builds a user object and gets how long they have to live.
        let userTimeToLive = TimeToLive()
        return userTimeToLive.buildTxtForToday()
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
        let qualityOfServiceClass = QOS_CLASS_UTILITY
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        var notificationArray = [UILocalNotification]()
        dispatch_async(backgroundQueue, {
            println("This is run on the background queue")
            
            for day in 1..<numDays+1{
                let (messageBody, messageFireDate) = userTimeToLive.buildTxtForFutureDate(NSDate(), daysInFuture: day)
                var localNotification = UILocalNotification()
                //localNotification.fireDate = messageFireDate
                
                let later = NSCalendar.currentCalendar().dateByAddingUnit(
                    .CalendarUnitMinute,
                    value: day,
                    toDate: today,
                    options: NSCalendarOptions(0))
                localNotification.fireDate = later
                
                localNotification.alertBody = messageBody
                localNotification.timeZone = NSTimeZone.defaultTimeZone()
                notificationArray.append(localNotification)
                //UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            }

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                println("This is run on the main queue, after the previous code in outer block")
                println(notificationArray.count)
                for localNotification in notificationArray {
                    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                }
                println("done scheduiling")
            })
        })

        prefs.setObject(true, forKey:"notificationSet")
    
    }
    
    func updateView(sender : AnyObject) {
        //this fires when the app transitions from background to foreground.
        var text = getUserText()
        txtView.text = text
    }
    
}
