//
//  ShowTimeToLiveViewController.swift
//  ttl
//
//  Created by andrew timmons on 8/20/15.
//  Copyright (c) 2015 andy. All rights reserved.
//

import UIKit

class ShowTimeToLiveViewController: UIViewController {

    let today = NSDate()
    let expirationDate = NSUserDefaults.standardUserDefaults().objectForKey("expirationDate") as! NSDate!
    let birthday = NSUserDefaults.standardUserDefaults().objectForKey("birthday") as! NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()    
        self.view.backgroundColor = UIColor.whiteColor()

        //calc days to live
        var daysToLive = calculateDayDifference()
        //calc months to live
        var monthsToLive = calculateMonthDifference()
        //calc years to live
        var yearsToLive = calculateYearDifference()
        //calc days in life
        var daysInLife = calculateDaysInLife()
        //calc percent of life left
        var percentOfLifeLived = 100.0 - 100*Float(daysToLive.toInt()!)/Float(daysInLife)
        var percentOfLifeLivedString = String(format: "%.4f", percentOfLifeLived)
        //build text view
        var txtView = buildTxtView(daysToLive, monthsToLive: monthsToLive, yearsToLive: yearsToLive, percentOfLifeLivedString: percentOfLifeLivedString)
        
        self.view.addSubview(txtView)

    }
    
    func calculateDaysInLife()  -> Float {
        //returns number of days between day of birth and estimated expiration date.
        let cal = NSCalendar.currentCalendar()
        let unit:NSCalendarUnit = .CalendarUnitDay
        let components = cal.components(unit, fromDate: birthday, toDate: expirationDate, options: nil)
        return Float(components.day)
    }
   
    func calculateDayDifference()  -> String {
        //returns number of days between today and estimated expiration date.
        let cal = NSCalendar.currentCalendar()
        let unit:NSCalendarUnit = .CalendarUnitDay
        let components = cal.components(unit, fromDate: today, toDate: expirationDate, options: nil)
        return String(components.day)
    }
    

    func calculateMonthDifference()  -> String {
        //returns number of months between today and estimated expiration date.
        let cal = NSCalendar.currentCalendar()
        let unit:NSCalendarUnit = .CalendarUnitMonth
        let components = cal.components(unit, fromDate: today, toDate: expirationDate, options: nil)
        return String(components.month)
    }
    
    func calculateYearDifference()  -> String {
        //returns number of years between today and estimated expiration date.
        let cal = NSCalendar.currentCalendar()
        let unit:NSCalendarUnit = .CalendarUnitYear
        let components = cal.components(unit, fromDate: today, toDate: expirationDate, options: nil)
        return String(components.year)
    }
    
    func buildTxtView(daysToLive:String, monthsToLive:String, yearsToLive:String, percentOfLifeLivedString:String) -> UITextView {
        //builds textview and text to tell you how long you lived
        var txtView = UITextView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        txtView.userInteractionEnabled = false
        txtView.textAlignment = NSTextAlignment.Center
        txtView.font =  UIFont(name: "helvetica", size: self.view.frame.size.height/16)
        txtView.text = "You've lived about\n" + percentOfLifeLivedString + "%\n of your life.\n\n\n" + "You have roughly \n" + daysToLive + " days\n" + " left to live."
        
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
    
}
