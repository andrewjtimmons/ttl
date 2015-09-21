//
//  ResetBirthdayViewController.swift
//  ttl
//
//  Created by andrew timmons on 9/20/15.
//  Copyright (c) 2015 andy. All rights reserved.
//

import UIKit

class ResetBirthdayViewController: UIViewController {
    
    @IBOutlet weak var resetBirthdayButton: UIButton!
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var txtView = buildTxtView()
        self.view.addSubview(txtView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func buildTxtView() -> UITextView {
        //builds textview for asking if user wants to redo birthday
        
        var navHeight = self.navigationController!.navigationBar.frame.size.height
        
        var txtView = UITextView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        txtView.userInteractionEnabled = false
        txtView.textAlignment = NSTextAlignment.Center
        txtView.font =  UIFont(name: "helvetica", size: self.view.frame.size.height/18)
        
        txtView.text = "Are you sure you want to reset your birthday?"
        
        //code to make the text view frame the exact size of the content.  From http://stackoverflow.com/questions/50467/how-do-i-size-a-uitextview-to-its-content
        let fixedWidth = txtView.frame.size.width
        txtView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = txtView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = txtView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height + 2*navHeight)
        txtView.frame = newFrame;
        
        //set center to middle of screen
        txtView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)
        
        return txtView
    }
    
    @IBAction func ResetBirthday(sender: UIButton) {
        prefs.removeObjectForKey("birthday")
        prefs.removeObjectForKey("expirationDate")
        prefs.synchronize()
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