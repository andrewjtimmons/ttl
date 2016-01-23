//
//  ShowTimeToLiveViewController.swift
//  ttl
//


import UIKit

class ShowTimeToLiveViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    var pageStrings: [String] = []
    var pageViews: [UITextView?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageStrings = [String("lol"),
            String("omg")]
        
        let pageCount = pageStrings.count
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount

        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        let txtView = UITextView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        txtView.userInteractionEnabled = false
        txtView.textAlignment = NSTextAlignment.Center
        txtView.font =  UIFont(name: "helvetica", size: self.view.frame.size.height/18)
        txtView.text = pageStrings[0]

        scrollView.addSubview(txtView)
        
    }
}
