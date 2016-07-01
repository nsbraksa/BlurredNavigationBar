//
//  ViewController.swift
//  BlurredNavigationBar
//
//  Created by Zakaria Braksa on 7/1/16.
//  Copyright © 2016 Zakaria Braksa. All rights reserved.
//

import UIKit
import Advance

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var navBarIsBlurred = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let barButtonBottomY = 64
        let initialOffset = 64
        let tableViewHeaderHeight = 240
        let blurOffset : CGFloat = CGFloat(tableViewHeaderHeight) - CGFloat(initialOffset) - CGFloat(barButtonBottomY)
        
        let visualEffectView = self.navigationController?.navigationBar.viewWithTag(1)
        
        if scrollView.contentOffset.y > blurOffset && navBarIsBlurred == false {
            
            0.0.animateTo(1.0, duration: 0.05, timingFunction: LinearTimingFunction()) { (value) in
                visualEffectView?.alpha = CGFloat(value)
            }
            
            navBarIsBlurred = true
        }
        else if scrollView.contentOffset.y < blurOffset && navBarIsBlurred == true {
            
            1.0.animateTo(0.0, duration: 0.1, timingFunction: LinearTimingFunction()) { (value) in
                visualEffectView?.alpha = CGFloat(value)
            }
            
            navBarIsBlurred = false
        }

    }
    
    func configureNavigationBar(){
        
        // Make UINavigationBar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController!.view.backgroundColor = UIColor.clearColor()
        
        // Calculate bounds for UIVisualEffectView
        var bounds = self.navigationController?.navigationBar.bounds as CGRect!
        bounds.offsetInPlace(dx: 0.0, dy: -20.0)
        bounds.size.height = bounds.height + 20.0
        
        // Set up UIVisualEffectView
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        visualEffectView.frame = bounds
        visualEffectView.tag = 1
        visualEffectView.alpha = 0
        visualEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.navigationController?.navigationBar.addSubview(visualEffectView)
        self.navigationController?.navigationBar.sendSubviewToBack(visualEffectView)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// Implements UITableViewDataSource methods
extension ViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("SimpleCell")! as UITableViewCell
        
        cell.textLabel!.text = "🍏🍎🍐🍊🍋🍉"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
}

// Implements UITableViewDelegate methods
extension ViewController : UITableViewDelegate {
    
}

