# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'TestPv' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TestPv
	pod 'Alamofire', '~> 5.5'
	pod 'DropDown', '2.3.13'

end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
			config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
			config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
		end
	end
end
