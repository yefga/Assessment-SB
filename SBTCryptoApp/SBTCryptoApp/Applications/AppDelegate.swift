//
//  AppDelegate.swift
//  SBTCryptoApp
//
//  Created by Yefga on 07/07/21.
//

import UIKit
import AlamofireNetworkActivityLogger

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        #if DEBUG
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
        #endif
        
        let frame = UIScreen.main.bounds
        window = UIWindow.init(frame: frame)
        
        let vc = TopListsRouter.shared.createModule()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
}

extension UIViewController {
    func topmostViewController() -> UIViewController {
        if let navigationVC = self as? UINavigationController,
           let topVC = navigationVC.topViewController {
            return topVC.topmostViewController()
        }
        if let tabBarVC = self as? UITabBarController,
           let selectedVC = tabBarVC.selectedViewController {
            return selectedVC.topmostViewController()
        }
        if let presentedVC = presentedViewController {
            return presentedVC.topmostViewController()
        }
        if let childVC = children.last {
            return childVC.topmostViewController()
        }
        return self
    }
}

extension UIApplication {
    func topmostViewController() -> UIViewController? {
        return windows.filter {$0.isKeyWindow}.first?.rootViewController?.topmostViewController()
    }
}
