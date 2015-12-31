//
//  ViewController.swift
//  GCProgressSample
//
//  Created by keygx on 2015/12/31.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit
import GradientCircularProgress

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var styleTableView: UITableView!
    
    var timer: NSTimer?
    var v: Double = 0.0
    var available: Bool = true
    let progress = GradientCircularProgress()
    
    let styleTitleList = [
        "Style.swift",
        "BlueDarkStyle.swift",
        "OrangeClearStyle.swift",
        "GreenLightStyle.swift",
        "BlueIndicatorStyle.swift",
        "MyStyle.swift",
    ]
    
    let styleDetailList = [
        "at Ratio",
        "Basic",
        "at Ratio",
        "Basic",
        "at Ratio",
        "Basic",
        "at Ratio",
        "Basic",
        "at Ratio",
        "Basic",
        "at Ratio",
        "Basic",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleTableView.delegate = self
        styleTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController {
    
    func showProgress(section section: Int, row: Int) {
        switch section {
        case 0:
            // Style.swift
            switch row {
            case 0:
                self.progress.showAtRatio(display: true, style: Style())
                self.startProgressAtRatio()
            case 1:
                self.progress.show(message: "Loading", style: Style())
                self.delayCloseProgress()
            default: break
            }
        case 1:
            // BlueDarkStyle.swift
            switch row {
            case 0:
                self.progress.showAtRatio(display: true, style: BlueDarkStyle())
                self.startProgressAtRatio()
            case 1:
                self.progress.show(message: "Loading", style: BlueDarkStyle())
                self.delayCloseProgress()
            default: break
            }
        case 2:
            // OrangeClearStyle.swift
            switch row {
            case 0:
                self.progress.showAtRatio(display: true, style: OrangeClearStyle())
                self.startProgressAtRatio()
            case 1:
                self.progress.show(message: "Loading", style: OrangeClearStyle())
                self.delayCloseProgress()
            default: break
            }
        case 3:
            // GreenLightStyle.swift
            switch row {
            case 0:
                self.progress.showAtRatio(display: true, style: GreenLightStyle())
                self.startProgressAtRatio()
            case 1:
                self.progress.show(message: "Loading", style: GreenLightStyle())
                self.delayCloseProgress()
            default: break
            }
        case 4:
            // BlueIndicatorStyle.swift
            switch row {
            case 0:
                self.progress.showAtRatio(display: false, style: BlueIndicatorStyle())
                self.startProgressAtRatio()
            case 1:
                self.progress.show(style: BlueIndicatorStyle())
                self.delayCloseProgress()
            default: break
            }
        case 5:
            // MyStyle.swift
            switch row {
            case 0:
                self.progress.showAtRatio(display: true, style: MyStyle())
                self.startProgressAtRatio()
            case 1:
                self.progress.show(message: "Loading", style: MyStyle())
                self.delayCloseProgress()
            default: break
            }
        default: break
        }
    }
    
    // for demo
    func delayCloseProgress() {
        let delay = 2.0 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            self.progress.dismiss()
            self.available = true
        })
    }
    // for demo
    func startProgressAtRatio() {
        self.v = 0.0
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(
            0.01,
            target: self,
            selector: "updateProgressAtRatio",
            userInfo: nil,
            repeats: true
        )
        NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSRunLoopCommonModes)
    }
    // for demo
    func updateProgressAtRatio() {
        self.v += 0.01
        
        self.progress.updateRatio(CGFloat(v))
        
        if self.v > 1.00 {
            self.timer!.invalidate()
            self.progress.dismiss() { Void in
                self.available = true
            }
            
            return
        }
    }
}

// UITableView
extension ViewController {
    
    // cell tap event
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(self.styleTitleList[indexPath.section]) : \(self.styleDetailList[indexPath.row])")
        
        if self.available {
            self.available = false
            self.showProgress(section: indexPath.section, row: indexPath.row)
        }
    }
    
    // section count
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.styleTitleList.count
    }
    
    // section title
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.styleTitleList[section]
    }
    
    // row count
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.styleTitleList.count > section {
            return 2
        } else {
            return 0
        }
    }
    
    // cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellIdentifier = "CustomCell"
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)!
        cell.textLabel?.text = self.styleDetailList[indexPath.row]
        
        return cell
    }
}
