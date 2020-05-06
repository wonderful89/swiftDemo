# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

# 支持flutter 模块
flutter_application_path = "./flutter_module"
#eval(File.read(File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')), binding)
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'SwiftDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  
  install_all_flutter_pods(flutter_application_path)
  #pod 'flutter_app_module', :path => './flutterFrameworks'

  # Pods for SwiftDemo
  pod 'SwiftyBeaver'
  pod 'Log'
  pod 'SnapKit'
  #pod 'HandyJSON', '~> 5.0.1'
  pod 'HandyJSON',:git => 'https://github.com/alibaba/HandyJSON.git', :branch => 'dev_for_swift5.0'
  pod 'DZNEmptyDataSet'
  pod 'MJRefresh'
  
end
