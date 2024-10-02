# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RandomCatApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RandomCatApp

  pod 'Alamofire', '~> 5.9.1'
  pod 'Kingfisher', '~> 7.0'
  pod 'R.swift', '~> 7.3.2'
  pod 'SVProgressHUD', '~> 2.3.1'
  pod 'lottie-ios', '~> 4.4.3'

  target 'RandomCatAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RandomCatAppUITests' do
    # Pods for testing
  end
  
  post_install do |installer|
   installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
   end
  end

end
