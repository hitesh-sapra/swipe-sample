//
//  RemoteServices.swift
//  SwipeSample
//
//  Created by Code Optimal Solutions Ios on 24/08/23.
//

import Foundation
import Alamofire
import SwiftyJSON
class NetworkingHelper{
    
    
    // MARK:  INITIALIZE Session
    /// - Returns: Returns initializes session object
    static  func managerInit()->Session{
        let manager = Session.default
        manager.session.configuration.timeoutIntervalForRequest = 30
        return manager
    }
    
    // MARK:  METHOD getService
    /// - Parameters:
    ///   - url: EndPoint
    ///   - completionHandler: call back when receive data from Server
    ///
    class  func getService(url:String,completionHandler: @escaping (JSON?, Error?,Int?) -> ()){
        let manager = NetworkingHelper.managerInit()
        LoaderManager.shared.showLoader()
        manager.request(url, method:.get,interceptor: nil).responseData { (response) in
            LoaderManager.shared.hideLoader()
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                completionHandler(json, nil,response.response?.statusCode)
            case .failure(let error):
                completionHandler(nil, error,response.response?.statusCode)
            }
        }
    }
    
    // MARK:  METHOD MultipartService
    /// - Parameters:
    ///   - url: EndPoint
    ///   - parameters: Body payload
    ///   - images: Images Dictionary
    ///   - Uploading_Status: uploading progress
    ///   - completionHandler: call back
    ///
    
    class func multipartService(url:String,loaderMsg:String,parameters:[String:Any],images:[String:UIImage]?=nil,Uploading_Status: @escaping (Int) -> (),completionHandler: @escaping (JSON?, Error?, Int?) -> ()){
        let manager = NetworkingHelper.managerInit()
        LoaderManager.shared.showLoader()
        manager.upload(multipartFormData: { (multipartFormData) in
            if images != nil{
                for (key, value) in images! {
                    let imageData = value.jpegData(compressionQuality: 0.5)
                    multipartFormData.append(imageData!, withName:key , fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpg")
                }
            }
            
            for (key, value) in parameters {
                
                multipartFormData.append("\(value)".data(using:.utf8)!, withName: key)
            }
            
        }, to: url,method:.post)
        
        
        .uploadProgress { progress in
            Uploading_Status(Int(progress.fractionCompleted*100))
        }
        .responseData { response in
            LoaderManager.shared.hideLoader()
            switch response.result{
            case .success(let value):
                
                let json = JSON(value)
                print(json)
                completionHandler(json, nil,response.response?.statusCode)
                
            case .failure(let error):
                completionHandler(nil, error,response.response?.statusCode)
            }
        }
    }
}
