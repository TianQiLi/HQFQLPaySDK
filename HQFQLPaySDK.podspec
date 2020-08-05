Pod::Spec.new do |s|
  s.name         = "HQFQLPaySDK"
  s.version      = "1.5.3.2"
  s.summary      = "hq乐卡支付SDK"
  s.homepage     = "https://github.com/TianQiLi/HQFQLPaySDK"
  s.platform     = :ios, "8.0"
  s.authors = "tq"
  s.source       = { :git => "https://github.com/TianQiLi/HQFQLPaySDK.git", :tag =>"#{s.version}"}
  s.vendored_frameworks = 'FQLPaySDK/FQLPay.framework','FQLPaySDK/MGFaceIDBaseKit.framework','FQLPaySDK/MGFaceIDIDCardKernelKit.framework','FQLPaySDK/MGFaceIDIDCardKit.framework','FQLPaySDK/MGFaceIDLiveDetect.framework'
  s.requires_arc = true
  s.frameworks = 'CoreMotion','Contacts','AdSupport','CoreLocation','AddressBook','CoreTelephony','SystemConfiguration','CFNetwork','MobileCoreServices'
  s.libraries = 'resolv.9','stdc++','z'
  valid_archs = ['armv7s','armv7','arm64','x86_64','arm64e']
  s.xcconfig = {
    'VALID_ARCHS' =>  valid_archs.join(' '),
  }
  s.pod_target_xcconfig = { :CLANG_CXX_LANGUAGE_STANDARD => "c++11", :CLANG_CXX_LIBRARY => "libc++",'ARCHS[sdk=iphonesimulator*]' => '$(ARCHS_STANDARD_64_BIT)'}
  s.resource = 'FQLPaySDK/FQLPayResource.bundle','FQLPaySDK/MGFaceIDIDCardResouce.bundle','FQLPaySDK/MGFaceIDLiveCustomDetect.bundle'
 
 s.dependency  'AFNetworking/NSURLSession' ,'~>3.0'
 s.dependency  'AFNetworking/Security','~>3.0'
 s.dependency  'AFNetworking/Serialization','~>3.0'
 s.dependency  'AFNetworking/Reachability','~>3.0'
 
  s.dependency  'YTKKeyValueStore', '~> 0.1.2'
  s.dependency  'MJExtension', '~> 3.1.0'
  s.dependency  'GZIP'

end


