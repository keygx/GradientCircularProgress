//
//  AsyncUtil.swift
//  GCProgressSample
//
//  Created by keygx on 2016/02/20.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation

class AsyncUtil {
    
    func dispatchOnMainThread(block: () -> (), delay: Double) {
        if delay == 0 {
            dispatch_async(dispatch_get_main_queue()) {
                block()
            }
            return
        }
        
        let d = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(d, dispatch_get_main_queue()) {
            block()
        }
    }
}
