//
//  UIApplication+Extension.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 24/08/23.
//

import Foundation
import UIKit
internal extension UIApplication {

    ///Returns the first active window in the application
    var keyWindow: UIWindow? {
        return UIApplication.shared.windows.filter { $0.isKeyWindow }.first
    }
}
