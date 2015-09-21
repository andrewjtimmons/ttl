//
//  ViewController.swift
//  ttl
//
//  Created by andrew timmons on 8/19/15.
//  Copyright (c) 2015 andy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let prefs = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var setBirthdayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        components.setValue(75, forComponent: NSCalendarUnit.CalendarUnitYear);
        var expirationDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: birthday, options: NSCalendarOptions(0))
        
        prefs.setObject(expirationDate, forKey:"expirationDate")
        prefs.synchronize()
        
        performSegueWithIdentifier("birthdaySetSegue", sender: self)

        
        //self.presentViewController(ShowTimeToLiveViewController(), animated: true, completion: nil)

        
    }
 

}

