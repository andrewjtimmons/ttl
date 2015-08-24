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
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setBirthdayValue(sender: UIButton) {
        prefs.setObject(birthdayPicker.date, forKey:"birthday")
        
        self.presentViewController(ShowTimeToLiveViewController(), animated: true, completion: nil)

        
    }
 

}

