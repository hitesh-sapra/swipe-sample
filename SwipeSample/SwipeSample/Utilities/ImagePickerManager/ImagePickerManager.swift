//
//  ImagePickerManager.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 25/08/23.
//

import Foundation
import UIKit

//protocol ImagePickerDelegate: AnyObject {
//    func didSelectImage(_ image: UIImage)
//}
//
//class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    weak var delegate: ImagePickerDelegate?
//    var presentingViewController: UIViewController?
//    
//    func pickImage(from viewController: UIViewController) {
//        presentingViewController = viewController
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        viewController.present(imagePicker, animated: true, completion: nil)
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        
//        if let selectedImage = info[.originalImage] as? UIImage {
//            delegate?.didSelectImage(selectedImage)
//        }
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//}
