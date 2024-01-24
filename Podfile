# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Geo_Map' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Geo_Map
  pod 'IQKeyboardManagerSwift'
  pod 'SVProgressHUD'
  pod 'SDWebImage'
  pod 'Toast-Swift'
  pod 'TTTAttributedLabel'
  
  # Pods for API Call Manager
  pod 'EVReflection/Alamofire','~> 5.10.1'
  pod 'Alamofire','~> 4.9.1'
  
  # Firebase Pods
  #pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Messaging'
  pod 'Firebase/Auth'
  pod 'ACFloatingTextfield-Swift'
#  , '~> 1.7'
  
  pod 'SignaturePad'
  
  pod 'DZNEmptyDataSet'
  pod 'SwiftyJSON'
end


post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
               end
          end
   end
end
