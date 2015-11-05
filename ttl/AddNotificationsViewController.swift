//
//  AddNotificationsViewController.swift
//  ttl
//
//  Created by andrew timmons on 11/5/15.
//  Copyright (c) 2015 andy. All rights reserved.
//

import UIKit

class AddNotificationsViewController: UIViewController {
    let prefs = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
