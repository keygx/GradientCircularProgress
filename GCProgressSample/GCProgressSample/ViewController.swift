//
//  ViewController.swift
//  GCProgressSample
//
//  Created by keygx on 2016/03/12.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit
import GradientCircularProgress

class ViewController: UIViewController {
    
    // UI
    enum UsageType {
        case Window
        case SubView
    }
    
    let styleList: [(String, StyleProperty)] = [
        ("Style.swift", Style()),
        ("BlueDarkStyle.swift", BlueDarkStyle()),
        ("OrangeClearStyle.swift", OrangeClearStyle()),
        ("GreenLightStyle.swift", GreenLightStyle()),
        ("BlueIndicatorStyle.swift", BlueIndicatorStyle()),
        ("MyStyle.swift", MyStyle()),
    ]
    
    var usageType: UsageType = .Window
    
    var seletedStyleIndex: Int = 0 {
        willSet {
            styleLabel.text = styleList[newValue].0
        }
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var btnAtRatio: MyButton!
    @IBOutlet weak var btnBasic: MyButton!
    @IBOutlet weak var btnUpdateMessage: MyButton!

    // Progress
    let progress = GradientCircularProgress()
    var progressView: UIView?
    
    // Demo
    var timer: NSTimer?
    var v: Double = 0.0
    var available: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usageType = .Window
        seletedStyleIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func segmentedControlAction(sender: AnyObject) {
        switch sender.selectedSegmentIndex {
        case 0:
            usageType = .Window
        case 1:
            usageType = .SubView
        default:
            break
        }
    }
    
    @IBAction func btnChooseStyleAction(sender: AnyObject) {
        
        let styleTitleList: [String] = styleList.map {$0.0}
        
        let params = Parameters(
            title: nil,
            message: nil,
            cancelButton: "Cancel",
            otherButtons: styleTitleList
        )
        
        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 1:
                self.seletedStyleIndex = buttonIndex - 1
                self.btnUpdateMessage.status = .Normal
            case 2:
                self.seletedStyleIndex = buttonIndex - 1
                self.btnUpdateMessage.status = .Normal
            case 3:
                self.seletedStyleIndex = buttonIndex - 1
                self.btnUpdateMessage.status = .Disabled
            case 4:
                self.seletedStyleIndex = buttonIndex - 1
                self.btnUpdateMessage.status = .Normal
            case 5:
                self.seletedStyleIndex = buttonIndex - 1
                self.btnUpdateMessage.status = .Disabled
            case 6:
                self.seletedStyleIndex = buttonIndex - 1
                self.btnUpdateMessage.status = .Normal
            default: break
                // Cancel
            }
        }
    }
    
    @IBAction func btnAtRatioAction(sender: AnyObject) {
        if available {
            return
        }
        available = true
        
        if usageType == .Window {
            showAtRatio()
        } else {
            showAtRatioTypeSubView()
        }
    }
    
    @IBAction func btnBasicAction(sender: AnyObject) {
        if available {
            return
        }
        available = true
        
        if usageType == .Window {
            showBasic()
        } else {
            showBasicTypeSubView()
        }
    }
    
    @IBAction func btnUpdateMessageAction(sender: AnyObject) {
        if available {
            return
        }
        available = true
        
        if usageType == .Window {
            showUpdateMessage()
        } else {
            showUpdateMessageTypeSubView()
        }
    }
}

// UIWindow
extension ViewController {
    
    func showAtRatio() {
        var displayFlag: Bool
        
        switch seletedStyleIndex {
        case 4:
            displayFlag = false
        default:
            displayFlag = true
        }
        
        progress.showAtRatio(display: displayFlag, style: styleList[seletedStyleIndex].1)
        startProgressAtRatio()
    }
    
    func showBasic() {
        progress.show(message: "Loading...", style: styleList[seletedStyleIndex].1)
        delayCloseProgress()
    }
    
    func showUpdateMessage() {
        progress.show(message: "Download\n0 / 4", style: styleList[seletedStyleIndex].1)
        startProgressBasic()
    }
}

// SubView
extension ViewController {
    
    func showAtRatioTypeSubView() {
        var displayFlag: Bool
        
        switch seletedStyleIndex {
        case 4:
            displayFlag = false
        default:
            displayFlag = true
        }
        
        progressView = progress.showAtRatio(frame: getRect(), display: displayFlag, style: styleList[seletedStyleIndex].1)
        progressView?.layer.cornerRadius = 12.0
        view.addSubview(progressView!)
        
        startProgressAtRatio()
    }
    
    func showBasicTypeSubView() {
        progressView = progress.show(frame: getRect(), message: "Loading...", style: styleList[seletedStyleIndex].1)
        progressView?.layer.cornerRadius = 12.0
        view.addSubview(progressView!)
        
        delayCloseProgress()
    }
    
    func showUpdateMessageTypeSubView() {
        progressView = progress.show(frame: getRect(), message: "Download\n0 / 4", style: styleList[seletedStyleIndex].1)
        progressView?.layer.cornerRadius = 12.0
        view.addSubview(progressView!)
        
        startProgressBasic()
    }
}

// for demo
extension ViewController {
    
    func delayCloseProgress() {
        AsyncUtil().dispatchOnMainThread({
            switch self.usageType {
            case .Window:
                self.progress.dismiss()
                self.available = false
            case .SubView:
                self.progress.dismiss(progress: self.progressView!)
                self.available = false
            }
        },
        delay: 2.0)
    }
    
    func startProgressBasic() {
        v = 0.0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(
            0.01,
            target: self,
            selector: #selector(updateMessage),
            userInfo: nil,
            repeats: true
        )
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    func updateMessage() {
        v += 0.002
        
        if v > 1.00 {
            progress.updateMessage(message: "Download\n4 / 4")
            timer!.invalidate()
            
            AsyncUtil().dispatchOnMainThread({
                    self.progress.updateMessage(message: "Completed!")

                    switch self.usageType {
                    case .Window:
                        self.progress.dismiss() { Void in
                            self.available = false
                        }
                    case .SubView:
                        self.progress.dismiss(progress: self.progressView!) { Void in
                            self.available = false
                        }
                    }
                }, delay: 0.8)
            
            return
        
        } else if v > 0.75 {
            progress.updateMessage(message: "Download\n3 / 4")
        
        } else if v > 0.5 {
            progress.updateMessage(message: "Download\n2 / 4")
        
        } else if v > 0.25 {
            progress.updateMessage(message: "Download\n1 / 4")
        }
    }
    
    func startProgressAtRatio() {
        v = 0.0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(
            0.01,
            target: self,
            selector: #selector(updateProgressAtRatio),
            userInfo: nil,
            repeats: true
        )
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    func updateProgressAtRatio() {
        v += 0.01
        
        progress.updateRatio(CGFloat(v))
        
        if v > 1.00 {
            timer!.invalidate()
            
            switch usageType {
            case .Window:
                progress.dismiss() { Void in
                    self.available = false
                }
            case .SubView:
                progress.dismiss(progress: progressView!) { Void in
                    self.available = false
                }
            }
            return
        }
    }
    
    func getRect() -> CGRect {
        return CGRectMake(
            view.frame.origin.x + 15,
            (view.frame.size.height - view.frame.size.width) / 2,
            view.frame.size.width - 30,
            view.frame.size.width - 30)
    }
}
