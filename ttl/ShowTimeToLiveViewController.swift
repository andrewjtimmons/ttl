//
//  ShowTimeToLiveViewController.swift
//  ttl
//


import UIKit

class ShowTimeToLiveViewController: UIViewController {
   
    let prefs = NSUserDefaults.standardUserDefaults()
    var txtView = UITextView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.view.backgroundColor = UIColor.whiteColor()
        
        var text = getUserText()
        txtView = buildTxtView(text)
        
        self.view.addSubview(txtView)
        
        //listener to refresh view when returning from background state.
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(
            self,
            selector: "updateView:",
            name:UIApplicationWillEnterForegroundNotification,
            object: nil
        )
    }
    
    func getUserText() -> String {
        //builds a user object and gets how long they have to live.
        let userTimeToLive = TimeToLive()
        return userTimeToLive.buildTxtForToday()
    }
    
    func buildTxtView(text: String) -> UITextView {
        //builds textview and text to tell you how long you lived
        
        var navHeight = self.navigationController!.navigationBar.frame.size.height

        var txtView = UITextView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        txtView.userInteractionEnabled = false
        txtView.textAlignment = NSTextAlignment.Center
        txtView.font =  UIFont(name: "helvetica", size: self.view.frame.size.height/18)
        txtView.text = text

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
    
       
    func updateView(sender : AnyObject) {
        //this fires when the app transitions from background to foreground.
        var text = getUserText()
        txtView.text = text
    }
    
}
