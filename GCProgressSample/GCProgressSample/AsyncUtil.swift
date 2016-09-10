//
//  AsyncUtil.swift
//  GCProgressSample
//
//  Created by keygx on 2016/02/20.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation

class AsyncUtil {
    
    func dispatchOnMainThread(_ block: @escaping () -> (), delay: Double) {
        if delay == 0 {
            DispatchQueue.main.async {
                block()
            }
            return
        }
        
        let d = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: d) {
            block()
        }
    }
}
