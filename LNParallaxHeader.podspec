Pod::Spec.new do |s|
    
  s.name                  = 'LNParallaxHeader'
  s.version               = '1.0.0'
  s.summary               = 'Header parallax effect in UICollectionView'
  s.homepage              = 'https://github.com/LanarsInc/LNParallaxHeader'
  s.license               = { :type => 'BSD', :file => 'LICENSE' }
  s.author                = { 'OleksandrLan' => 'oleksandr@lanars.com' }
  s.source                = { :git => 'https://github.com/LanarsInc/LNParallaxHeader.git', :tag => s.version.to_s }
  s.frameworks            = 'UIKit'
  s.ios.deployment_target = '10.0'
  s.swift_version         = '5.0'
  s.source_files = 'LNParallaxHeader/Classes/**/*'

end
