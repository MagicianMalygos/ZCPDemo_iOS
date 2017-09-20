Pod::Spec.new do |s|

  s.name          = "ZCPKit"
  s.version       = "1.0.0"
  s.summary       = "It`s a Framework."
  s.description   = <<-DESC
                      It`s a Framework.
                    DESC

  s.homepage      = "null"
  s.license       = "MIT"
  s.author        = { "朱超鹏" => "z164757979@163.com" }
  s.source        = { :git => "null", :tag => "#{s.version}" }
  
  s.platform      = :ios, '8.0'

  s.source_files  = "ZCPKit/Framework/**/*.{h,m}"
  s.resources     = "ZCPKit/Common/Util/Navigator/viewMap.plist"
  s.framework     = "Foundation", "UIKit"

end
