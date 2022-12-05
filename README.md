# ebusiness
e-commerce app
# 在swift中使用 第三方OC库

### No 1： 创建头文件Bridging-Header.h
  ![image](https://user-images.githubusercontent.com/86242993/205653768-aa9a9ca4-dea5-4c56-9a39-5d0c46728679.png)
### No 2： 在Bridging-Header.h中引用这个OC的库名
  这里是使用的第三方OC库 EllipsePageControl，自定义page Control轮播图底部的自动轮播小圆点
  ![image](https://user-images.githubusercontent.com/86242993/205654057-d4ff593c-9bb4-4119-a517-10d4bef6c20e.png)
### No 3： Build Settings中搜索bridg, 找到Objective-C Bridging Header, 添加 Bridging-Header.h
  ![image](https://user-images.githubusercontent.com/86242993/205654170-dd665347-c761-4726-8a7d-524c2a400b96.png)
### No 4, 配置完后，OC的方法会被转化成swift的调用方法，我们只需要按照swift的调用方法使用即可
------------------------------------------------------------------------------------
# 首页自动轮不图片
使用的第三swift库文件FSPagerView： https://github.com/WenchaoD/FSPagerView#banner

# Swift UIColor 使用十六进制颜色
### 使用Extension 扩展

                  extension String {
                      /// 十六进制字符串颜色转为UIColor
                      /// - Parameter alpha: 透明度
                      func uicolor(alpha: CGFloat = 1.0) -> UIColor {
                          // 存储转换后的数值
                          var red: UInt64 = 0, green: UInt64 = 0, blue: UInt64 = 0
                          var hex = self
                          // 如果传入的十六进制颜色有前缀，去掉前缀
                          if hex.hasPrefix("0x") || hex.hasPrefix("0X") {
                              hex = String(hex[hex.index(hex.startIndex, offsetBy: 2)...])
                          } else if hex.hasPrefix("#") {
                              hex = String(hex[hex.index(hex.startIndex, offsetBy: 1)...])
                          }
                          // 如果传入的字符数量不足6位按照后边都为0处理，当然你也可以进行其它操作
                          if hex.count < 6 {
                              for _ in 0..<6-hex.count {
                                  hex += "0"
                              }
                          }

                          // 分别进行转换
                          // 红
                          Scanner(string: String(hex[..<hex.index(hex.startIndex, offsetBy: 2)])).scanHexInt64(&red)
                          // 绿
                          Scanner(string: String(hex[hex.index(hex.startIndex, offsetBy: 2)..<hex.index(hex.startIndex, offsetBy: 4)])).scanHexInt64(&green)
                          // 蓝
                          Scanner(string: String(hex[hex.index(startIndex, offsetBy: 4)...])).scanHexInt64(&blue)

                          return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
                      }
                  }
## 使用
        let mLabel = UILabel(frame: CGRect(x: 95, y: 120, width: 200, height: 40))
        mLabel.text="我是文本"
        mLabel.textColor="#189659".uicolor()
        mLabel.textAlignment=NSTextAlignment.center
        mLabel.minimumScaleFactor=0.5
        mLabel.adjustsFontSizeToFitWidth=true
        mLabel.layer.borderColor="#1A1A1A".uicolor().cgColor
        mLabel.layer.borderWidth = 5
        mLabel.layer.cornerRadius=10
        view.addSubview(mLabel)

