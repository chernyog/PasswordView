//
//  UIDevice+Extension.swift
//  CYPasswordViewDemo
//
//  Created by yong.chen on 2020/9/21.
//  Copyright © 2020 yong.chen. All rights reserved.
//

import UIKit

extension UIDevice {
    /** 获取安全间距 */
    public class func safeAreaInsets() -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
        }
        return UIEdgeInsets.zero
    }
    
    /** 判断是否是刘海屏手机 */
    public class func isIphoneX() -> Bool {
        return self.safeAreaInsets().bottom > 0.0
    }
}
