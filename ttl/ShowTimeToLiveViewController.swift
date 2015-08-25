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
        
        
        var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = "hi"
        self.view.addSubview(label)
        
        var daysToLive = calculateDayDifference()
        println(daysToLive)
        
        var monthsToLive = calculateMonthDifference()
        println(monthsToLive)
        
        var yearsToLive = calculateYearDifference()
        println(yearsToLive)
    
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
