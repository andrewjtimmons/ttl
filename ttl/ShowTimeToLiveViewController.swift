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
        //first label
        var label = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/5))
        label.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/10)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = NSTextAlignment.Center
        label.text = "You have about"
        self.view.addSubview(label)
        
        //calc days to live
        var daysToLive = calculateDayDifference()
        println(daysToLive)
        //create label for days to live
        var labelDays = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/5))
        labelDays.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*3/10)
        labelDays.adjustsFontSizeToFitWidth = true
        labelDays.textAlignment = NSTextAlignment.Center
        labelDays.text = daysToLive + " days,"
        self.view.addSubview(labelDays)
        
        //calc months to live
        var monthsToLive = calculateMonthDifference()
        println(monthsToLive)
        //create label for months to live
        var labelMonths = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/5))
        labelMonths.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*5/10)
        labelMonths.adjustsFontSizeToFitWidth = true
        labelMonths.textAlignment = NSTextAlignment.Center
        labelMonths.text = monthsToLive + " months,"
        self.view.addSubview(labelMonths)
        
        //calc years to live
        var yearsToLive = calculateYearDifference()
        println(yearsToLive)
        //create label for years to live
        var labelYears = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/5))
        labelYears.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*7/10)
        labelYears.adjustsFontSizeToFitWidth = true
        labelYears.textAlignment = NSTextAlignment.Center
        labelYears.text = yearsToLive + " years"
        self.view.addSubview(labelYears)

        //create label for left to be alive
        var labelRemaining = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/5))
        labelRemaining.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*9/10)
        labelRemaining.adjustsFontSizeToFitWidth = true
        labelRemaining.textAlignment = NSTextAlignment.Center
        labelRemaining.text = " left to live."
        self.view.addSubview(labelRemaining)
    
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
