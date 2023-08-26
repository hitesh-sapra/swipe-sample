//
//  LoaderManager.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 24/08/23.
//

import Foundation
import UIKit

/// This Class is responsible for presenting and dismissing the loader to
/// indicate the user that some activity is happening
class LoaderManager {
    static let shared = LoaderManager()

    /// This variable helps to keep count of active api requests
    /// This is usefull in case multiple api calls take place at one time
    /// Instead of showing multiple loaders, a single loader is presented
    /// Untill all api calls are not finished
    private var activeRequestsCount = 0
    
    private init() {}
    
    
    /// Present the loader with a custom message by default set to "Please Wait"
    /// - Parameter msg: Send Custom Message to show while presenting loader
    func showLoader(withMessage msg:String = ConstantText.defaultLoaderMsg) {
        
        if activeRequestsCount == 0{
            let loaderAlertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
            loaderAlertController.view.tintColor = UIColor.black
            let loaderView: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50))
            loaderView.hidesWhenStopped = true
            loaderView.style = UIActivityIndicatorView.Style.medium
            loaderView.startAnimating()
            loaderAlertController.view.addSubview(loaderView)
            UIWindow.keyWin?.rootViewController?.present(loaderAlertController, animated: true)
        }
        activeRequestsCount += 1
    }
    
    /// Dissmiss/remove loader from screen
    func hideLoader() {
        activeRequestsCount -= 1
        if activeRequestsCount <= 0 {
            UIWindow.keyWin?.rootViewController?.dismiss(animated: true)
        }
    }
}
