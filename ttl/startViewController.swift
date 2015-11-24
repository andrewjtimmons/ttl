//
//  startViewController.swift
//  ttl
//
//

import UIKit

class startViewController: UIViewController {
    let prefs = NSUserDefaults.standardUserDefaults()

    override func viewDidAppear(animated: Bool) {
        if (prefs.objectForKey("birthday") == nil){
            performSegueWithIdentifier("doesNotHaveBirthdaySegue", sender: self)
        } else {
            performSegueWithIdentifier("doesHaveBirthdaySegue", sender: self)
        }  
    }
    
    
}
