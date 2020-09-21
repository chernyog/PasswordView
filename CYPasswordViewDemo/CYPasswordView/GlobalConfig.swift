//
//  GlobalConfig.swift
//  CYPasswordViewDemo
//
//  Created by yong.chen on 2020/9/21.
//  Copyright © 2020 yong.chen. All rights reserved.
//

import UIKit

struct Const {
    /** 密码框的高度 */
    static let CYPasswordInputViewHeight: CGFloat = (196 + 216 + UIDevice.safeAreaInsets().bottom * 2)
    /** 密码框标题的高度 */
    static let CYPasswordViewTitleHeight: CGFloat = 55
    /** 密码框显示或隐藏时间 */
    static let CYPasswordViewAnimationDuration: CGFloat = 0.25
    /** 关闭按钮的宽高 */
    static let CYPasswordViewCloseButtonWH: CGFloat = 15
    /** 关闭按钮的左边距 */
    static let CYPasswordViewCloseButtonMarginLeft: CGFloat = 10
    /** 输入点的宽高 */
    static let CYPasswordViewPointnWH: CGFloat = 10
    /** TextField图片的宽 */
    static let CYPasswordViewTextFieldWidth: CGFloat = 297
    /** TextField图片的高 */
    static let CYPasswordViewTextFieldHeight: CGFloat = 50
    /** TextField图片向上间距 */
    static let CYPasswordViewTextFieldMarginTop: CGFloat = 25
    /** 忘记密码按钮向上间距 */
    static let CYPasswordViewForgetPWDButtonMarginTop: CGFloat = 12
    
    static let ScreenWidth = UIScreen.main.bounds.width
    static let ScreenHeight = UIScreen.main.bounds.height
    
    /** 密码位数 */
    static let NumCount = 6
    
    static let CYPasswordViewKeyboardNumberKey = "CYPasswordViewKeyboardNumberKey"
}
