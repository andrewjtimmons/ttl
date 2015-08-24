//
//  ShowTimeToLiveViewController.swift
//  ttl
//
//  Created by andrew timmons on 8/20/15.
//  Copyright (c) 2015 andy. All rights reserved.
//

import UIKit

class ShowTimeToLiveViewController: UIViewController {

    let prefs = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()    
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        if let birthday = prefs.objectForKey("birthday") as! NSDate!{
            println(birthday)
        }else{
            //Nothing stored in NSUserDefaults yet. Set a value.
            println("there aint no bday and yr code is jankay")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
