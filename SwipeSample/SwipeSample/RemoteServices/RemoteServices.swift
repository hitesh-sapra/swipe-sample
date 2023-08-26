//
//  RemoteServices.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 24/08/23.
//

import Foundation
import SwiftyJSON
class RemoteServices{
    static func getProductList(completion:@escaping(JSON)->Void){
        NetworkingHelper.getService(url: ConstantUrl.GetProductListApi) { json, error, statusCode in
            guard let json = json else{return}
            completion(json)
        }
    }
    static func addProduct(params:[String:String],image:[String:UIImage]? = nil,completion:@escaping(JSON)->Void){
        NetworkingHelper.multipartService(url: ConstantUrl.AddProductListApi,loaderMsg: ConstantText.addProductLoaderMsg, parameters: params,images: image) { status in
            //
        } completionHandler: { jsonData, error, statusCode in
            guard let jsonData = jsonData else{return}
            if jsonData["success"].boolValue{
                completion(jsonData)
            }
        }
    }
}
