#
# Be sure to run `pod lib lint GSScrollableLineChart.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GSScrollableLineChart'
  s.version          = '0.1.0'
  s.summary          = 'Swift tool for creating smooth and scrollable line charts in iOS apps'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  The ScrollableLineChart library is a robust and versatile Swift library designed to create smooth and scrollable line charts in iOS applications. This library caters to developers who need an efficient and customizable way to present time-series data or any other data that benefits from a linear graphical representation.
                       DESC

  s.homepage         = 'https://github.com/megaganjotsingh/GSScrollableLineChart'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'megaganjotsingh' => 'megaganjotsingh@gmail.com' }
  s.source           = { :git => 'https://github.com/megaganjotsingh/GSScrollableLineChart.git', :tag => s.version.to_s }
   s.social_media_url = 'www.linkedin.com/in/gaganjot-singh-40b40b100'

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.source_files = 'Source/**/*'
  
end
