#
# Be sure to run `pod lib lint DCNavigationMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DCNavigationMenu"
  s.version          = "0.1.0"
  s.summary          = "Your mom is so fat."
  s.description      = "dafhsjkd hfjklahsdjfklahsdjkf lahjkdfhkaj sdhklafshdkfahskdhajklsdhjkafhsdjhdhasd hjdhakl dfshjkahsdj klfa shdjkafh sjkdh aksdhk asdhhhhhhhh hl ashjdkf asdf."
  s.homepage         = "https://github.com/youweit/DCNavigationMenu"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Youwei Teng" => "ranyouwei3@gmail.com" }
  s.source           = { :git => "https://github.com/youweit/DCNavigationMenu.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'DCNavigationMenu' => ['Pod/Assets/*.png']
  }
  #s.resources = [""]
  #s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'

end
