//
//  ViewController.swift
//  CYPasswordViewDemo
//
//  Created by yong.chen on 2020/9/21.
//  Copyright © 2020 yong.chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var passwordView: CYPasswordView?
    
    var flag = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "支付"
    }

    func cancel() {
        print("关闭密码框")
    }
    
    func forgetPWD() {
        print("忘了密码")
    }
    
    @IBAction func showPasswordView(_ sender: Any) {
        passwordView = CYPasswordView()
        
        passwordView?.loadingText = "提交中..."
        passwordView?.cancelBlock = {[weak self] in
            self?.cancel()
        }
        passwordView?.forgetPasswordBlock = {[weak self] in
            self?.forgetPWD()
        }
        passwordView?.finish = {[weak self] password in
            self?.passwordView?.startLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                self?.flag = !(self?.flag ?? false)
                if (self?.flag == true) {
                    print("购买成功")
                    self?.passwordView?.requestComplete(state: true, message: "购买成功")
                } else {
                    print("购买失败")
                    self?.passwordView?.requestComplete(state: false)
                }
                self?.passwordView?.stopLoading()
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    self?.passwordView?.hide()
                }
            }
        }
        passwordView?.show(in: self.view.window)
    }
    
    deinit {
        print("\(NSStringFromClass(self.classForCoder)): [\(#function): 我走了]")
    }
}

