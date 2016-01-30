//
//  ViewController.swift
//  ttl
//

import UIKit

class ViewController: UIViewController {

    let prefs = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var setBirthdayButton: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        // If the user deletes the app and reinstalls old notifications can be present.
        // This gets rid of them.
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    @IBAction func setBirthdayValue(sender: UIButton) {
        // Uses NSUserDefaults to set the following values.
        // birthday: the day, month and year the user was born.
        // expirationDate: the day, month and year the user will 
        // pass away (on average).
        
        let cal: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        let birthday: NSDate = cal.dateBySettingHour(0, minute: 0, second: 0, ofDate: birthdayPicker.date, options: NSCalendarOptions())!
        
        prefs.setObject(birthday, forKey:"birthday")
        
        var components = NSDateComponents()
        components.setValue(75, forComponent: NSCalendarUnit.Year);
        var expirationDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: birthday, options: NSCalendarOptions(rawValue: 0))
        
        prefs.setObject(expirationDate, forKey:"expirationDate")
        prefs.synchronize()
        
        performSegueWithIdentifier("birthdaySetSegue", sender: self)
    }
    
}

