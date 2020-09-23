//
//  UIColor+Extension.swift
//  CYPasswordViewDemo
//
//  Created by yong.chen on 2020/9/21.
//  Copyright © 2020 yong.chen. All rights reserved.
//

import UIKit

extension Bundle {
    static var bundle: Bundle?
    static func cy_bundle() -> Bundle? {
        if bundle == nil {
            if let url = Bundle(for: PasswordView.self).url(forResource: "PasswordView", withExtension: "bundle") {
                bundle = Bundle(url: url)
            }
        }
        return bundle
    }
}
