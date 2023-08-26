//
//  ProductDataModel.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 25/08/23.
//

import Foundation
import SwiftyJSON
class ProductDataModel:Hashable{
    var productName = ""
    var productType = ""
    var price = ""
    var tax = ""
    var image = ""
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(productName)
            hasher.combine(productType)
            hasher.combine(price)
            hasher.combine(tax)
            hasher.combine(image)
        }
    
    static func ==(lhs: ProductDataModel, rhs: ProductDataModel) -> Bool {
           return lhs.productName == rhs.productName &&
                  lhs.productType == rhs.productType &&
                  lhs.price == rhs.price &&
                  lhs.tax == rhs.tax &&
                  lhs.image == rhs.image
       }
    
    init(productName: String = "", productType: String = "", price: String = "", tax: String = "", image: String = "") {
        self.productName = productName
        self.productType = productType
        self.price = price
        self.tax = tax
        self.image = image
    }
    
    init(jsonData:JSON){
        productName = jsonData["product_name"].stringValue
        productType = jsonData["product_type"].stringValue
        let tempTax = round(jsonData["tax"].doubleValue * 100) / 100
        tax = String(format: "%.2f", tempTax)
        let tempPrice = round(jsonData["price"].doubleValue * 100) / 100
        price = String(format: "%.2f", tempPrice)
        image = jsonData["image"].stringValue
    }
}
