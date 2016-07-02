Pod::Spec.new do |s|
  s.name         = "GradientCircularProgress"
  s.version      = "3.4.0"
  s.summary      = "Customizable progress indicator library in Swift"
  s.homepage     = "https://github.com/keygx/GradientCircularProgress"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "keygx" => "y.kagiyama@gmail.com" }
  s.social_media_url   = "http://twitter.com/keygx"
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.source       = { :git => "https://github.com/keygx/GradientCircularProgress.git", :tag => "#{s.version}" }
  s.source_files  = "Source/*"
  s.requires_arc = true
end
