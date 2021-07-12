//
//  UIViewController.swift
//  SBTCryptoApp
//
//  Created by Yefga on 11/07/21.
//

import UIKit

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
