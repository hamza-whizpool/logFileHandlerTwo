#
# Be sure to run `pod lib lint logFileHandlerIOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'logFileHandlerIOS'
  s.version          = '0.3.0'
  s.summary          = 'This project will create a logfile and main record of logfile'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  'This project will create a logfile and main record of logfile.just import this library and check this pod'
                       DESC

  s.homepage         = 'https://github.com/hamza-whizpool/logFileHandlerTwo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hamza Mughal' => 'hamza.mughal@whizpool.com' }
  s.source           = { :git => 'https://github.com/hamza-whizpool/logFileHandlerTwo.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'Classes/**/*.swift'
  s.swift_version = '5.0'
  s.resources = 'Classes/**/*.{xib,xcassets,close}'

  
  # s.resource_bundles = {
  #   'logFileHandlerIOS' => ['logFileHandlerIOS/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SSZipArchive', '~> 2.4.2'
end
#https://github.com/hamza-whizpool/logFileHandler
