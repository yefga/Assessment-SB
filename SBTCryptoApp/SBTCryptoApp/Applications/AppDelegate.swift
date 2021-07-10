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

