#
#  Be sure to run `pod spec lint CYPasswordView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "PasswordView"
  s.version      = "1.0.0"
  s.authors     = { 'chernyog' => 'chenyios@126.com' }
  s.summary      = "PasswordView 是一个模仿支付宝输入支付密码的密码框。"
  s.homepage     = "https://github.com/chernyog/PasswordView"
  s.license      =  { :type => "MIT", :file => "LICENSE" }
  s.author             = { "cheny" => "chenyios@126.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/chernyog/PasswordView.git", :tag => s.version }
  s.source_files  = "CYPasswordView/*.swift"
  s.resources = "CYPasswordView/CYPasswordView.bundle"
  s.requires_arc = true

end
