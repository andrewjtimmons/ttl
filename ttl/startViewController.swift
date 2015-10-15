//
//  startViewController.swift
//  ttl
//
//  Created by andrew timmons on 10/15/15.
//  Copyright (c) 2015 andy. All rights reserved.
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
