//
//  ViewController.swift
//  GCProgressSample
//
//  Created by keygx on 2015/06/21.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit
import GradientCircularProgress

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var timer: NSTimer?
    var v: Double = 0.0
    var available: Bool = true
    var progress = GradientCircularProgress()
    
    let styleList = [
        (Style(),                       true,  "Loading"),
        (BlueDarkStyle() as Style,      true,  "Loading"),
        (OrangeDarkStyle() as Style,    true,  "Loading"),
        (IndicatorStyle() as Style,        false, ""),
        (BlueIndicatorStyle() as Style, false, "")
    ]
    
    @IBOutlet weak var styleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleTableView.delegate = self
        styleTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return styleList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellIdentifier: String = "CustomCell"
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)!
        
        let className: UILabel = cell.viewWithTag(100) as! UILabel
        let btn1: UIButton = cell.viewWithTag(101) as! UIButton
        let btn2: UIButton = cell.viewWithTag(102) as! UIButton
        
        let clazz = styleList[indexPath.row].0 as Style
        className.text = NSStringFromClass(clazz.dynamicType).componentsSeparatedByString(".").last! as String
        btn1.addTarget(self, action: "didTouchButton:event:", forControlEvents: UIControlEvents.TouchUpInside)
        btn2.addTarget(self, action: "didTouchButton:event:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    func listViewIndexPathForControlEvent(event: UIEvent) -> NSIndexPath {
        
        let touch: UITouch = event.allTouches()!.first!
        let point: CGPoint = touch.locationInView(styleTableView)
        let indexPath: NSIndexPath = styleTableView.indexPathForRowAtPoint(point)!
        
        return indexPath
    }
    
    func didTouchButton(sender: UIButton, event: UIEvent) {
        
        if available {
            available = false
        
            let indexPath: NSIndexPath = listViewIndexPathForControlEvent(event)
            
            self.showDummyProgress(indexPath.row, tag: sender.tag)
        }
    }
    
    func showDummyProgress(row: Int, tag: Int) {
        
        let item = styleList[row]
        
        if tag == 101 {
            
            progress.showAtRatio(display: item.1, style: item.0)
            
            v = 0.0
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateProgressAtRatio", userInfo: nil, repeats: true)
            timer!.fire()
            
        } else {
            
            if item.2.isEmpty {
                progress.show(style: item.0)
            } else {
                progress.show(message: item.2, style: item.0)
            }
            
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                self.progress.dismiss()
                self.available = true
            })
        }
    }
    
    func updateProgressAtRatio() {
        
        v += 0.01
        
        progress.updateRatio(CGFloat(v))
        
        if v > 1.00 {
            timer!.invalidate()
            progress.dismiss() { Void in
                self.available = true
            }
            
            return
        }
    }
}
