//
//  AboutViewController.swift
//  ttl
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let txtView = buildTxtView()
        self.view.addSubview(txtView)
    }
    
    func buildTxtView() -> UITextView {
        //builds textview for showing about menu text
        
        let navHeight = self.navigationController!.navigationBar.frame.size.height
        
        let txtView = UITextView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        txtView.userInteractionEnabled = false
        txtView.textAlignment = NSTextAlignment.Left
        txtView.font =  UIFont(name: "helvetica", size: self.view.frame.size.height/31)
        
        txtView.text = "This app does not tell you exactly how long you will live.  It just uses a rough estimate based on how long other human beings have lived.  You will most likely die before or after the estimated date.\n\nThe goal of this app is to help you to think positively about how you spend your time on earth and what you do with your life.\n\nAll data you put in this app is stored locally on your device.  The creator of this app will never use any of your data for commercial purposes.\n\nHave a great life."
        
        //code to make the text view frame the exact size of the content.  From http://stackoverflow.com/questions/50467/how-do-i-size-a-uitextview-to-its-content
        let fixedWidth = txtView.frame.size.width
        txtView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = txtView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = txtView.frame
        var maxWidth = max(newSize.width, fixedWidth)
        newFrame.size = CGSize(width: maxWidth - maxWidth/10, height: newSize.height + 2*navHeight)
        txtView.frame = newFrame;
        
        //set center to middle of screen
        txtView.center = CGPointMake(self.view.frame.size.width/2, (newFrame.size.height/2)+maxWidth/20)
        
        return txtView
    }

}
