//
//  Extension.swift
//  ImageScrollView
//
//  Created by 杨洋 on 15/12/31.
//  Copyright © 2015年 Sheepy. All rights reserved.
//

import Foundation

//为了解决retain cycle问题
typealias Proc = @convention(block) () -> ()
extension NSTimer {
    class func sy_scheduledTimeerWithTimeInterval(interval: NSTimeInterval, repeats: Bool, repeatHandler: Proc) {
        scheduledTimerWithTimeInterval(interval, target: self, selector: "sy_procInvoke:", userInfo: unsafeBitCast(repeatHandler, AnyObject.self), repeats: true)
    }
    
    class func sy_procInvoke(timer: NSTimer) {
        let proc = unsafeBitCast(timer.userInfo, Proc.self)
        proc()
    }
}
