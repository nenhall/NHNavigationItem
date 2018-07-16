#
#  Be sure to run `pod spec lint NHNavigationItem.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "NHNavigationItem"
  s.version      = "1.0.3"
  s.summary      = "在系统原生的导航栏上面随意定制导航按钮及自带侧滑返回手势的工具类"
  s.description  = <<-DESC
  一个完全支持在系统原生的导航栏上面随意定制导航按钮及自带侧滑返回手势的工具类，你只需要简单调用一句代码即可添加导航栏按钮，支持block回调及函数调用。
                   DESC

  s.homepage     = "https://github.com/nenhall/NHNavigationItem"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "nenhall" => "nenhall@126.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/nenhall/NHNavigationItem.git", :tag => "#{s.version}" }

  s.source_files  = "NHNavigationItem/*.{h,m}"
  s.public_header_files = "NHNavigationItem/*.h"

end
