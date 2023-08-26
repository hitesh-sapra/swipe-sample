//
//  AddProductViewModel.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 26/08/23.
//

import Foundation
import UIKit
class AddProductViewModel{
    var productName = ""
    var productType = ""
    var productPrice = ""
    var productTax = ""
    var productImages = [UIImage]()
    var successDelegate:AddProductSuccessDelegate?
    func validation(){
        if productName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            AlertManager().showAlert(message: ConstantText.productNameRequired)
        }else if productPrice.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            AlertManager().showAlert(message: ConstantText.productPriceRequired)
        }else if productTax.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            AlertManager().showAlert(message: ConstantText.productTaxRequired)
        }else if productType.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            AlertManager().showAlert(message: ConstantText.productTypeRequired)
        }else{
            let params = ["product_name":productName,
                          "product_type":productType,
                          "price":productPrice,
                          "tax":productTax]
            var imageParam:[String:UIImage]? = nil
            if !productImages.isEmpty{
                imageParam = ["files[]":productImages.first!]
            }
            RemoteServices.addProduct(params: params, image: imageParam) { json in
                var tempObj = ProductDataModel(jsonData: json["product_details"])
                self.successDelegate?.productAddedSuccessfully(withNewProduct: tempObj)
            }
        }
    }
}


protocol AddProductSuccessDelegate{
    func productAddedSuccessfully(withNewProduct product:ProductDataModel)
}
