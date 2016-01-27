//
//  TimeToLive.swift
//  ttl
//


import Foundation

class TimeToLive {
        
    func buildTxtForToday() -> String {
        // Returns a string with how many days and pecent left in their life for
        // today's date.
        var message = ""
        let today = NSDate()
        let expirationDate = NSUserDefaults.standardUserDefaults().objectForKey("expirationDate") as! NSDate!
        let birthday = NSUserDefaults.standardUserDefaults().objectForKey("birthday") as! NSDate!
        
        //calc days to live
        let daysToLive = calculateDayDifference(today, expirationDate: expirationDate)
        //calc days in life
        let daysInLife = calculateDaysInLife(birthday, expirationDate: expirationDate)
        //calc percent of life left
        let percentOfLifeLived = caluclatePercentOfLifeLived(daysToLive, daysInLife: daysInLife)
        let percentOfLifeLivedString = String(format: "%.0f", percentOfLifeLived)

        //customize message
        if Int(daysToLive)! <= 0 {
            message = "Congrats.\nMany people do not make it this far.\nEnjoy the rest of your time to live."
        } else {
            message =  "You have roughly \n" + daysToLive + " days\n" + " left to live.\n\n\n" + "You've lived about\n" + percentOfLifeLivedString + "%\n of your life."
        }
    
        return message
    }
    
    func buildTxtForFutureDate(today: NSDate, daysInFuture: Int) -> (String, NSDate) {
        // Takes in a number of days in the future.
        // Returns a string with day and percentage left for a future date.
        var message = ""
        
        let today = today
        var components = NSDateComponents()
        components.setValue(daysInFuture, forComponent: NSCalendarUnit.Day);
        components.timeZone = NSTimeZone.systemTimeZone()
        let tempFutureDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: today, options: NSCalendarOptions(rawValue: 0))
        
        let cal: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let startOfFutureDate: NSDate = cal.startOfDayForDate(tempFutureDate!)
        let futureDate: NSDate = cal.dateBySettingHour(8, minute: 0, second: 0, ofDate: startOfFutureDate, options: NSCalendarOptions())!
        
        let expirationDate = NSUserDefaults.standardUserDefaults().objectForKey("expirationDate") as! NSDate!
        let birthday = NSUserDefaults.standardUserDefaults().objectForKey("birthday") as! NSDate!
        
        //calc days to live
        var daysToLive = calculateDayDifference(futureDate, expirationDate: expirationDate)
        var daysInLife = calculateDaysInLife(birthday, expirationDate: expirationDate)
        //calc percent of life left
        var percentOfLifeLived = caluclatePercentOfLifeLived(daysToLive, daysInLife: daysInLife)
        var percentOfLifeLivedString = String(format: "%.0f", percentOfLifeLived)
        
        //customize message
        if Int(daysToLive)! <= 0 {
            message = "Congrats. Many people do not make it this far. Enjoy the rest of your time to live."
        } else {
            message = "You have roughly " + daysToLive + " days" + " left to live. You have lived about " + percentOfLifeLivedString + "% of your life."
        }
        
        return (message, futureDate)
    }

    func calculateDayDifference(today: NSDate, expirationDate: NSDate)  -> String {
        //returns number of days between today and estimated expiration date.
        let cal = NSCalendar.currentCalendar()
        let unit:NSCalendarUnit = .Day
        let components = cal.components(unit, fromDate: today, toDate: expirationDate, options: [])
        return String(components.day)
    }
    
    func calculateDaysInLife(birthday: NSDate, expirationDate: NSDate)  -> Float {
        //returns number of days between day of birth and estimated expiration date.
        let cal = NSCalendar.currentCalendar()
        let unit:NSCalendarUnit = .Day
        let components = cal.components(unit, fromDate: birthday, toDate: expirationDate, options: [])
        return Float(components.day)
    }
    
    func caluclatePercentOfLifeLived(daysToLive: String, daysInLife: Float) -> Float {
        // returns percentage of life the user has lived.  
        let percentLived = 100.0 - 100.0*Float(Int(daysToLive)!)/Float(daysInLife)
        return percentLived
    }


}