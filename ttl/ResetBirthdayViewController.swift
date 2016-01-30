//
//  ResetBirthdayViewController.swift
//  ttl
//

import UIKit

class ResetBirthdayViewController: UIViewController {
    
    @IBOutlet weak var resetBirthdayButton: UIButton!
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let txtView = buildTxtView()
        self.view.addSubview(txtView)
        
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(0,0,200,200)
        button.titleLabel!.font =  UIFont(name: "helvetica", size: self.view.frame.size.height/23)
        button.setTitle("Reset Birthday", forState: UIControlState.Normal)
        button.addTarget(self, action: "ResetBirthday:", forControlEvents: UIControlEvents.TouchUpInside)
        button.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-self.view.frame.size.height/6)
        
        self.view.addSubview(button)
    }
   
    
    func buildTxtView() -> UITextView {
        //builds textview for asking if user wants to redo birthday
        
        let navHeight = self.navigationController!.navigationBar.frame.size.height
        
        let txtView = UITextView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        txtView.userInteractionEnabled = false
        txtView.textAlignment = NSTextAlignment.Center
        txtView.font =  UIFont(name: "helvetica", size: self.view.frame.size.height/23)
        
        txtView.text = "Were you reborn with a new birthday?\n\nCongrats!\n\nClick below to change the date."
        
        //code to make the text view frame the exact size of the content.  From http://stackoverflow.com/questions/50467/how-do-i-size-a-uitextview-to-its-content
        let fixedWidth = txtView.frame.size.width
        txtView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = txtView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = txtView.frame
        var maxWidth = max(newSize.width, fixedWidth)
        newFrame.size = CGSize(width: maxWidth - maxWidth/10, height: newSize.height + 2*navHeight)
        txtView.frame = newFrame;
        
        //set center to middle of screen
        txtView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2.5)
        
        return txtView
    }
    
    func ResetBirthday(sender: UIButton) {
        // Resets users birthday and returns them to the first view controller.
        prefs.removeObjectForKey("birthday")
        prefs.removeObjectForKey("expirationDate")
        prefs.removeObjectForKey("notificationSet")
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        prefs.synchronize()
        performSegueWithIdentifier("resetBirthdaySegue", sender: self)
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