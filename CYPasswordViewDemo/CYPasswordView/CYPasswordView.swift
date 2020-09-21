//
//  CYPasswordView.swift
//  CYPasswordViewDemo
//
//  Created by yong.chen on 2020/9/21.
//  Copyright © 2020 yong.chen. All rights reserved.
//

import UIKit

class CYPasswordView: UIView {
    // MARK: - 私有属性
    private var tempStr = ""
    
    // MARK: - 公有属性
    var loadingText: String?
    /** 完成的回调block */
    var finish: ((String) -> Void)?
    /** 忘记密码的block */
    var forgetPasswordBlock: PasswordInputViewBlock?
    /** 取消的block */
    var cancelBlock: PasswordInputViewBlock?
    
    // MARK: - 懒加载
    private lazy var coverView: UIControl = {
        let view = UIControl()
        view.backgroundColor = UIColor.black
        view.alpha = 0.4
        view.frame = UIScreen.main.bounds
        return view
    }()
    
    /** 输入框 */
    private lazy var passwordInputView: CYPasswordInputView = {
        let view = CYPasswordInputView()
        view.cancelBlock = { [weak self] in
            self?.cancel()
        }
        view.forgetPasswordBlock = {[weak self] in
            self?.forgetPassword()
        }
        return view
    }()
    
    private lazy var txfResponsder: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.keyboardType = .numberPad
        view.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        view.isSecureTextEntry = true
        return view
    }()
    
    private lazy var imgRotation: UIImageView = {
        let view = UIImageView()
        view.image = loadImage("password_loading_b")
        view.sizeToFit()
        view.isHidden = true
        return view
    }()
    
    private lazy var lblMessage: UILabel = {
        let view = UILabel()
        view.text = loadingText ?? "支付中..."
        view.isHidden = true
        view.textColor = UIColor.darkGray
        view.font = UIFont.systemFont(ofSize: 13)
        view.textAlignment = .center
        return view
    }()
    
    // MARK: - 生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        imgRotation.centerX = passwordInputView.centerX
        imgRotation.centerY = passwordInputView.h * 0.5
        
        lblMessage.x = 0
        lblMessage.y = imgRotation.frame.maxY + 20
        lblMessage.w = Const.ScreenWidth
        lblMessage.h = 30
    }
    
    deinit {
        print("\(NSStringFromClass(self.classForCoder)): [\(#function): 我走了]")
    }
    
    // MARK: - 私有方法
    private func setupUI() {
        backgroundColor = UIColor.clear
        addSubview(coverView)
        addSubview(passwordInputView)
        addSubview(txfResponsder)
        
        passwordInputView.addSubview(imgRotation)
        passwordInputView.addSubview(lblMessage)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
    }
    
    @objc private func tap(_ recognizer: UITapGestureRecognizer) {
        let p = recognizer.location(in: passwordInputView)
        let f = CGRect(x: 39, y: 80, width: 297, height: 50)
        if f.contains(p) {
            txfResponsder.becomeFirstResponder()
        }
    }
    
    /** 输入框的取消按钮点击 */
    private func cancel() {
        resetPasswordView()
        cancelBlock?()
    }
    
    /** 输入框的忘记密码按钮点击 */
    private func forgetPassword() {
        resetPasswordView()
        forgetPasswordBlock?()
    }
    
    /** 重置密码框 */
    private func resetPasswordView() {
        hideKeyboard {[weak self] (finished) in
            self?.passwordInputView.isHidden = true
            self?.tempStr = ""
            self?.removeFromSuperview()
            self?.passwordInputView.setNeedsDisplay()
        }
    }
    
    // MARK: - 公有方法
    /** 弹出密码框 */
    open func show(in view: UIView?) {
        view?.addSubview(self)
        passwordInputView.h = Const.CYPasswordInputViewHeight
        passwordInputView.y = self.h
        passwordInputView.w = Const.ScreenWidth
        passwordInputView.x = 0
        
        lblMessage.text = loadingText ?? "支付中..."
        
        showKeyboard()
    }
    
    /** 隐藏密码框 */
    open func hide() {
        removeFromSuperview()
    }
    
    /** 开始加载 */
    open func startLoading() {
        startRotation(view: imgRotation)
        passwordInputView.clickable(false)
    }
    
    /** 加载完成 */
    open func stopLoading() {
        stopRotation(view: imgRotation)
        passwordInputView.clickable(true)
    }
    
    /** 请求完成 */
    open func requestComplete(state: Bool) {
        requestComplete(state: state, message: state ? "支付成功" : "支付失败")
    }
    
    /** 请求完成 */
    open func requestComplete(state: Bool, message: String) {
        lblMessage.text = message
        imgRotation.image = loadImage(state ? "password_success" : "password_error")
        
        
        
    }
    
    // MARK: - 私有方法
    /** 显示键盘 */
    private func showKeyboard() {
        txfResponsder.becomeFirstResponder()
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.init(), animations: {
            self.passwordInputView.y = Const.ScreenHeight - self.passwordInputView.h
        })
    }
    
    /** 隐藏键盘 */
    private func hideKeyboard() {
        hideKeyboard(nil)
    }
    
    private func hideKeyboard( _ completion: ((Bool) -> Void)?) {
        txfResponsder.endEditing(false)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            self.inputView?.transform = .identity
        }, completion: completion)
    }
    
    private func startRotation(view: UIView) {
        imgRotation.isHidden = false
        lblMessage.isHidden = false
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = Double.pi * 2.0
        rotationAnimation.duration = 2.0
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = Float(Int64.max)
        view.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    private func stopRotation(view: UIView) {
        view.layer.removeAllAnimations()
    }
}

// MARK: - <UITextFieldDelegate>
extension CYPasswordView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if tempStr.count == 0 {
            tempStr = string
        } else {
            tempStr = "\(tempStr)\(string)"
        }
        if string == "" {
            passwordInputView.deleteNumber()
            if tempStr.count > 0 {  // 删除最后一个字符串
                tempStr.removeLast()
            }
        } else {
            if tempStr.count == Const.NumCount {
                hideKeyboard()
                finish?(tempStr)
                finish = nil
                tempStr = ""
            }
            passwordInputView.number(userInfo: [Const.CYPasswordViewKeyboardNumberKey: string])
        }
        return true
    }
}
