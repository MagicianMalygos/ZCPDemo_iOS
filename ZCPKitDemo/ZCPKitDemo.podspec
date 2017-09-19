#
#  Be sure to run `pod spec lint ZCPKitDemo.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "ZCPKitDemo"
  s.version      = "1.0"
  s.summary      = "A short description of ZCPKitDemo."
  s.description  = <<-DESC
  abc
                   DESC
  s.license      = "MIT (example)"
  s.author             = { "朱超鹏" => "z164757979@163.com" }

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "http://EXAMPLE/ZCPKitDemo.git", :tag => "#{s.version}" }


  s.source_files  = "ZCPKitDemo/Framework/ZCPKit.h"


end
