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
    
    override func viewDidLoad() {
        super.viewDidLoad()    
        self.view.backgroundColor = UIColor.whiteColor()
        //calc percent of life left
        
        //calc days to live
        var daysToLive = calculateDayDifference()
        //calc months to live
        var monthsToLive = calculateMonthDifference()
        //calc years to live
        var yearsToLive = calculateYearDifference()

        var txtView = UITextView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        
        txtView.textAlignment = NSTextAlignment.Center
        txtView.font =  UIFont(name: "helvetica", size: self.view.frame.size.height/16)
        txtView.text = "You have about \n" + daysToLive + " days\n" + monthsToLive + " months\n" + yearsToLive + " years\n" + " left to live."
        
        //code to make the text view frame the exact size of the content.  From http://stackoverflow.com/questions/50467/how-do-i-size-a-uitextview-to-its-content
        let fixedWidth = txtView.frame.size.width
        txtView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = txtView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = txtView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        txtView.frame = newFrame;
        
        //set center to middle of screen
        txtView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)
        
        
        self.view.addSubview(txtView)
        let verticalCenter = NSLayoutConstraint(item: txtView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        self.view.addConstraint(verticalCenter)
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
    
    
    
}
