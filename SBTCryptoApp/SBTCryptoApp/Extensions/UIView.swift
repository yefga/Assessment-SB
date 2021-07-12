//
//  UIView.swift
//  SBTCryptoApp
//
//  Created by Yefga on 11/07/21.
//

import UIKit

extension UIView {
    var identifier: String {
        return className(some: self)
    }
}

public func className(some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}
