//
//  TimeToLive.swift
//  ttl
//


import Foundation

class TimeToLive {
        
    func buildTxtForToday() -> String {
        var message = ""
        let today = NSDate()
        let expirationDate = NSUserDefaults.standardUserDefaults().objectForKey("expirationDate") as! NSDate!
        let birthday = NSUserDefaults.standardUserDefaults().objectForKey("birthday") as! NSDate!
        
        //calc days to live
        var daysToLive = calculateDayDifference(today, expirationDate: expirationDate)
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
    
    func buildTxtForFutureDate(today: NSDate, daysInFuture: Int) -> (String, NSDate) {
        var message = ""
        
        let today = today
        var components = NSDateComponents()
        components.setValue(daysInFuture, forComponent: NSCalendarUnit.CalendarUnitDay);
        components.timeZone = NSTimeZone.systemTimeZone()
        let tempFutureDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: today, options: NSCalendarOptions(0))
        
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
        var percentOfLifeLivedString = String(format: "%.4f", percentOfLifeLived)
        
        //customize message
        if daysToLive.toInt()! <= 0 {
            message = "Congrats. Many people do not make it this far. Enjoy the rest of your time to live."
        } else {
            message = "You've lived about " + percentOfLifeLivedString + " percent of your life." + " You have roughly " + daysToLive + " days" + " left to live."
        }
        
        return (message, futureDate)
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