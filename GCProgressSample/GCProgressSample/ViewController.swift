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
        case window
        case subView
    }
    
    let styleList: [(String, StyleProperty)] = [
        ("Style.swift", Style()),
        ("BlueDarkStyle.swift", BlueDarkStyle()),
        ("OrangeClearStyle.swift", OrangeClearStyle()),
        ("GreenLightStyle.swift", GreenLightStyle()),
        ("BlueIndicatorStyle.swift", BlueIndicatorStyle()),
        ("MyStyle.swift", MyStyle()),
    ]
    
    var usageType: UsageType = .window
    
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
    var timer: Timer?
    var v: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usageType = .window
        seletedStyleIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func segmentedControlAction(_ sender: AnyObject) {
        switch sender.selectedSegmentIndex {
        case 0:
            usageType = .window
        case 1:
            usageType = .subView
        default:
            break
        }
    }
    
    @IBAction func btnChooseStyleAction(_ sender: AnyObject) {
        
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
                self.btnUpdateMessage.status = .normal
            case 2:
                self.seletedStyleIndex = buttonIndex - 1
                self.btnUpdateMessage.status = .normal
            case 3:
                self.seletedStyleIndex = buttonIndex - 1
                self.btnUpdateMessage.status = .disabled
            case 4:
                self.seletedStyleIndex = buttonIndex - 1
                self.btnUpdateMessage.status = .normal
            case 5:
                self.seletedStyleIndex = buttonIndex - 1
                self.btnUpdateMessage.status = .disabled
            case 6:
                self.seletedStyleIndex = buttonIndex - 1
                self.btnUpdateMessage.status = .normal
            default: break
                // Cancel
            }
        }
    }
    
    @IBAction func btnAtRatioAction(_ sender: AnyObject) {
        if progress.isAvailable {
            return
        }
        
        if usageType == .window {
            showAtRatio()
        } else {
            showAtRatioTypeSubView()
        }
    }
    
    @IBAction func btnBasicAction(_ sender: AnyObject) {
        if progress.isAvailable {
            return
        }
        
        if usageType == .window {
            showBasic()
        } else {
            showBasicTypeSubView()
        }
    }
    
    @IBAction func btnUpdateMessageAction(_ sender: AnyObject) {
        if progress.isAvailable {
            return
        }
        
        if usageType == .window {
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
            case .window:
                self.progress.dismiss()
            case .subView:
                self.progress.dismiss(progress: self.progressView!)
            }
        },
        delay: 2.0)
    }
    
    func startProgressBasic() {
        v = 0.0
        
        timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(updateMessage),
            userInfo: nil,
            repeats: true
        )
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    func updateMessage() {
        v += 0.002
        
        if v > 1.00 {
            progress.updateMessage(message: "Download\n4 / 4")
            timer!.invalidate()
            
            AsyncUtil().dispatchOnMainThread({
                    self.progress.updateMessage(message: "Completed!")

                    switch self.usageType {
                    case .window:
                        self.progress.dismiss()
                    case .subView:
                        self.progress.dismiss(progress: self.progressView!)
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
        
        timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(updateProgressAtRatio),
            userInfo: nil,
            repeats: true
        )
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    func updateProgressAtRatio() {
        v += 0.01
        
        progress.updateRatio(CGFloat(v))
        
        if v > 1.00 {
            timer!.invalidate()
            
            switch usageType {
            case .window:
                progress.dismiss()
            case .subView:
                progress.dismiss(progress: progressView!)
            }
            return
        }
    }
    
    func getRect() -> CGRect {
        return CGRect(
            x: view.frame.origin.x + 15,
            y: (view.frame.size.height - view.frame.size.width) / 2,
            width: view.frame.size.width - 30,
            height: view.frame.size.width - 30)
    }
}
