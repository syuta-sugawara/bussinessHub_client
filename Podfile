# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'ImageClassificator' do

  use_frameworks!

  target 'ImageClassificatorTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ImageClassificatorUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'Library' do
  project 'ImageClassificator'

  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ImageClassificator
  pod 'MDCSwipeToChoose', '0.2.3'
  pod 'Fabric', '1.7.9'
  pod 'Crashlytics', '3.10.5'
  pod 'Result', '~> 4.0.0'
  pod 'Alamofire', '~> 4.7'
  pod 'AlamofireObjectMapper', '~> 5.0'
  pod 'AlamofireImage', '~> 3.3'
  pod 'RxSwift', '~> 4.0'
  pod 'RxCocoa', '~> 4.0'
  pod 'R.swift', '~> 4.0'
  pod 'NSObject+Rx', '~> 4.3'
  pod 'Swinject', '~> 2.4'
  pod 'ReachabilitySwift', '~> 4.2'
  pod 'SVProgressHUD', '~> 2.2'
end

post_install do |installer|
    
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
    
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
        end
    end
end
