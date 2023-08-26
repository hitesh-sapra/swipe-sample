//
//  ProductListViewModel.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 25/08/23.
//

import Foundation


class ProductListViewModel{
    var dataList:[ProductDataModel] = []
    var dataDelegate:ProductVMDelegate?
    
    func getProductList(){
        RemoteServices.getProductList { jsonData in
            jsonData.forEach { (_,json) in
                self.dataList.append(ProductDataModel(jsonData: json))
            }
            self.dataDelegate?.dataListUpdated(withData: self.dataList)
        }
    }
    
    func searchProduct(searchText:String){
        var uniqueMatchingProducts: Set<ProductDataModel> = Set()

        // Loop through each product and check if the search text is contained in any variable
        for product in dataList {
            if product.productName.contains(searchText) ||
               product.productType.contains(searchText) ||
               product.price.contains(searchText) ||
               product.tax.contains(searchText) {
                uniqueMatchingProducts.insert(product)
            }
        }

        // Convert the set back to an array
        let finalResultArray: [ProductDataModel] = Array(uniqueMatchingProducts)
        if searchText == ""{
            dataDelegate?.dataListUpdated(withData: dataList)
        }else{
            dataDelegate?.dataListUpdated(withData: finalResultArray)
        }
    }
}


//MARK: ProductVMDelegate Protocol
///This is used to notify the View Controller class that the dataList variable is updated
///This will allow to make changes to view whenever dataList is changed
protocol ProductVMDelegate{
    func dataListUpdated(withData data:[ProductDataModel])
}
