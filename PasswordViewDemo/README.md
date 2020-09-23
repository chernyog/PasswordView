# PasswordView - Swift版本

---

`CYPasswordView`是一个模仿支付宝输入支付密码的密码框。

### 一、说明

---

* `CYPasswordView`是一个简单且实用的输入密码框
* 具体用法主要参考Demo程序

### 二、使用方法

---

~~####使用 CocoaPods~~

~~`pod 'CYPasswordView'`~~

#### 手动导入文件

1. 将`CYPasswordView`文件夹添加到项目中
2. 导入主头文件`#import "CYPasswordView.h"`

### 三、部分API的介绍

---

* 实例化`CYPasswordView`对象

``` swift
CYPasswordView()
```

* 弹出密码框

``` swift
open func show(in view: UIView?) {}
```

* 密码输入完成的回调

``` objc
var finish: ((String) -> Void)?
```

* 隐藏密码框

``` objc
open func hide() {}
```

* 开始加载（发送网络请求时，加载动画）

``` objc
open func startLoading() {}
```

* 加载完成（暂停动画）

``` objc
open func stopLoading() {}
```

* 请求完成

``` objc
open func requestComplete(state: Bool) {}
open func requestComplete(state: Bool, message: String) {}
```

* 设置对话框标题

``` swift
var title: String?
```

### 四、效果示例

---

![CYPasswordView](https://github.com/chernyog/CYPasswordView/blob/master/CYPasswordViewDemo/CYPasswordViewDemo/CYPasswordViewDemo.gif "CYPasswordView示例")
