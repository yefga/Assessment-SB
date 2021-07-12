source 'https://github.com/CocoaPods/Specs'

platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

workspace "SBTCrypto"

target 'SBTCryptoApp' do 
    project 'SBTCryptoApp/SBTCryptoApp.project'
    
    pod 'Alamofire'
    pod 'AlamofireObjectMapper'
    pod 'AlamofireNetworkActivityLogger'
    pod 'Starscream'
    
    target 'SBTCryptoAppTests' do
        inherit! :search_paths
        pod 'AlamofireObjectMapper'
    end

end

