//
//  CYPasswordInputView.swift
//  CYPasswordViewDemo
//
//  Created by yong.chen on 2020/9/21.
//  Copyright © 2020 yong.chen. All rights reserved.
//

import UIKit

typealias PasswordInputViewBlock = (() -> Void)

/// 从 bundle 中加载图片
func loadImage(_ imageName: String) -> UIImage? {
    return UIImage(named: "CYPasswordView.bundle/\(imageName)")
}

class CYPasswordInputView: UIView {
    // MARK: - 公有属性
    /// 标题
    var title: String?
    /// 点击忘了密码的回调
    var forgetPasswordBlock: PasswordInputViewBlock?
    /// 点击关闭按钮的回调
    var cancelBlock: PasswordInputViewBlock?
    
    // MARK: - 私有属性
    /** 保存用户输入的数字集合 */
    private var inputNumArray: [String] = []
    /** 关闭按钮 */
    private var btnClose: UIButton?
    /** 忘记密码 */
    private var btnForgetPWD: UIButton?
    
    // MARK: - 共有方法
    /** 响应用户按下数字键事件 */
    func number(userInfo: [String: String]) {
        guard let numObj = userInfo[Const.CYPasswordViewKeyboardNumberKey] else { return }
        if numObj.count >= Const.NumCount { return }
        inputNumArray.append(numObj)
        setNeedsDisplay()
    }
    
    /** 响应用户按下删除键事件 */
    func deleteNumber() {
        inputNumArray.removeLast()
        setNeedsDisplay()
    }
    
    /// 界面元素是否可点击
    func clickable(_ enable: Bool) {
        btnClose?.isUserInteractionEnabled = enable
        btnForgetPWD?.isUserInteractionEnabled = enable
    }
    
    // MARK: - 生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        // 设置关闭按钮坐标
        btnClose?.w = Const.CYPasswordViewCloseButtonWH
        btnClose?.h = Const.CYPasswordViewCloseButtonWH
        btnClose?.x = Const.CYPasswordViewCloseButtonMarginLeft
        btnClose?.centerY = Const.CYPasswordViewTitleHeight * 0.5
        
        // 设置忘记密码按钮的坐标
        btnForgetPWD?.x = Const.ScreenWidth - (Const.ScreenWidth - Const.CYPasswordViewTextFieldWidth) * 0.5 - CGFloat(btnForgetPWD?.w ?? 0)
        btnForgetPWD?.y = Const.CYPasswordViewTitleHeight + Const.CYPasswordViewTextFieldMarginTop + Const.CYPasswordViewTextFieldHeight + Const.CYPasswordViewForgetPWDButtonMarginTop
    }
    
    deinit {
        print("\(NSStringFromClass(self.classForCoder)): [\(#function): 我走了]")
    }
    
    override func draw(_ rect: CGRect) {
        // 画图
        let imgBackground = loadImage("password_background")
        let imgTextfield = loadImage("password_textfield")
        
        imgBackground?.draw(in: rect)
        
        let textfieldY = Const.CYPasswordViewTextFieldHeight + Const.CYPasswordViewTextFieldMarginTop
        let textfieldW = Const.CYPasswordViewTextFieldWidth
        let textfieldX = (Const.ScreenWidth - textfieldW) * 0.5
        let textfieldH = Const.CYPasswordViewTextFieldHeight
        imgTextfield?.draw(in: CGRect(x: textfieldX, y: textfieldY, width: textfieldW, height: textfieldH))
        
        // 画标题
        let title = self.title ?? "输入交易密码"
        let arrts = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        let nsTitle = NSString(string: title)
        let maxSize = CGSize(width: CGFloat(Int64.max), height: CGFloat(Int64.max))
        let size = nsTitle.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: arrts, context: nil).size
        let titleW = size.width
        let titleH = size.height
        let titleX = (self.w - titleW) * 0.5
        let titleY = (Const.CYPasswordViewTitleHeight - titleH) * 0.5
        let titleRect = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
        
        var attr: [NSAttributedString.Key: Any] = [:]
        attr[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 18)
        attr[NSAttributedString.Key.foregroundColor] = UIColor(r: 102, g: 102, b: 102)
        nsTitle.draw(in: titleRect, withAttributes: attr)
        
        // 画点
        let pointImage = loadImage("password_point")
        let pointW = Const.CYPasswordViewPointnWH
        let pointH = Const.CYPasswordViewPointnWH
        let pointY = textfieldY + (textfieldH - pointH) * 0.5
        var pointX: CGFloat = 0
        let cellW = textfieldW / CGFloat(Const.NumCount)
        let padding = (cellW - pointW) * 0.5
        for idx in 0..<inputNumArray.count {
            let v1 = CGFloat(2 * idx + 1) * padding
            pointX = textfieldX + v1 + CGFloat(idx) * pointW
            pointImage?.draw(in: CGRect(x: pointX, y: pointY, width: pointW, height: pointH))
        }
    }
    
    // MARK: - 私有方法
    private func setupSubViews() {
        // 关闭按钮
        let btnCancel = UIButton(type: .custom)
        addSubview(btnCancel)
        btnCancel.setBackgroundImage(loadImage("password_close"), for: .normal)
        btnCancel.setTitleColor(UIColor.darkGray, for: .normal)
        self.btnClose = btnCancel
        btnCancel.addTarget(self, action: #selector(btnCloseHandler), for: .touchUpInside)
        
        // 忘记密码
        let btnForgetPWD = UIButton(type: .custom)
        addSubview(btnForgetPWD)
        btnForgetPWD.setTitle("忘记密码？", for: .normal)
        btnForgetPWD.setTitleColor(UIColor(r: 0, g: 125, b: 227), for: .normal)
        btnForgetPWD.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btnForgetPWD.sizeToFit()
        self.btnForgetPWD = btnForgetPWD
        btnForgetPWD.addTarget(self, action: #selector(btnForgetPWDHandler), for: .touchUpInside)
    }
    
    @objc private func btnCloseHandler() {
        cancelBlock?()
        inputNumArray.removeAll()
    }
    @objc private func btnForgetPWDHandler() {
        forgetPasswordBlock?()
    }
}
