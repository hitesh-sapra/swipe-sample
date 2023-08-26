//
//  AlertManager.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 26/08/23.
//

import Foundation
import UIKit

class AlertManager{
    
    static var title = "SwipeSample"
    func showAlert(message: String, delegate: UIViewController = UIWindow.keyWin!.rootViewController!,onTap:(()->Void)? = nil) {
        
        let alert = UIAlertController(title:AlertManager.title, message: NSLocalizedString(message, comment: ""), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in
            if onTap != nil{
                onTap!()
            }
        }))
        delegate.present(alert, animated: true, completion: nil)
    }
}
