# Uncomment this line to define a global platform for your project
 platform :ios, '9.0'

target 'HyperApp' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
#https://github.com/goktugyil/EZLoadingActivity

pod 'Google/SignIn'
pod 'Onboard'

pod 'FBSDKCoreKit'
pod 'FBSDKShareKit'
pod 'FBSDKLoginKit'
    pod 'Alamofire', '~> 4.0'
pod 'RealmSwift', '~> 2.1.0’

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
  end

pod 'SDWebImage', '~>3.8'
    pod 'SwiftyJSON'
    pod 'UIScrollView-InfiniteScroll'
pod 'IQKeyboardManagerSwift', '4.0.6'
    pod 'AlamofireImage', '~> 3.1'
pod "CDAlertView"


end
