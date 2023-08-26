//
//  UIWindow+Extension.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 24/08/23.
//

import Foundation
import UIKit

extension UIWindow{
    ///Returns the first active window in the application
    static var keyWin: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
