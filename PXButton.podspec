Pod::Spec.new do |s|
  s.name             = "PXButton"
  s.version          = "0.1.2"
  s.summary          = "A button with a configurably aligned icon"
  s.description      = <<-DESC
                       A button with an optional image you can put in the left, the right, and right in the middle.
                       DESC
  s.homepage         = "https://github.com/pixio/PXButton"
  s.license          = 'MIT'
  s.author           = { "Daniel Blakemore" => "DanBlakemore@gmail.com" }
  s.source = {
   :git => "https://github.com/pixio/PXButton.git",
   :tag => s.version.to_s
  }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'PXButton' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
