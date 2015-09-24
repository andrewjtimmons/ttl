//
//  TimeToLive.swift
//  ttl
//
//  Created by andrew timmons on 9/24/15.
//  Copyright (c) 2015 andy. All rights reserved.
//

import Foundation

class TimeToLive {
        
    func buildTxt() -> String {
        var message = ""
        let today = NSDate()
        let expirationDate = NSUserDefaults.standardUserDefaults().objectForKey("expirationDate") as! NSDate!
        let birthday = NSUserDefaults.standardUserDefaults().objectForKey("birthday") as! NSDate!
        
        //calc days to live
        var daysToLive = calculateDayDifference(today, expirationDate: expirationDate)
        //calc months to live
        //var monthsToLive = calculateMonthDifference()
        //calc years to live
        //var yearsToLive = calculateYearDifference()
        //calc days in life
        var daysInLife = calculateDaysInLife(birthday, expirationDate: expirationDate)
        //calc percent of life left
        var percentOfLifeLived = caluclatePercentOfLifeLived(daysToLive, daysInLife: daysInLife)
        var percentOfLifeLivedString = String(format: "%.4f", percentOfLifeLived)

        //customize message
        if daysToLive.toInt()! <= 0 {
            message = "Congrats.\nMany people do not make it this far.\nEnjoy the rest of your time to live."
        } else {
            message = "You've lived about\n" + percentOfLifeLivedString + "%\n of your life.\n\n\n" + "You have roughly \n" + daysToLive + " days\n" + " left to live."
        }
    
        return message
    }

    func calculateDayDifference(today: NSDate, expirationDate: NSDate)  -> String {
        //returns number of days between today and estimated expiration date.
        let cal = NSCalendar.currentCalendar()
        let unit:NSCalendarUnit = .CalendarUnitDay
        let components = cal.components(unit, fromDate: today, toDate: expirationDate, options: nil)
        return String(components.day)
    }
    
    func calculateDaysInLife(birthday: NSDate, expirationDate: NSDate)  -> Float {
        //returns number of days between day of birth and estimated expiration date.
        let cal = NSCalendar.currentCalendar()
        let unit:NSCalendarUnit = .CalendarUnitDay
        let components = cal.components(unit, fromDate: birthday, toDate: expirationDate, options: nil)
        return Float(components.day)
    }
    
    func caluclatePercentOfLifeLived(daysToLive: String, daysInLife: Float) -> Float {
        //100.0 - 100.0*Float(daysToLive.toInt()!)/Float(daysInLife)
        var percentLived = 100.0 - 100.0*Float(daysToLive.toInt()!)/Float(daysInLife)
        return percentLived
    }


}