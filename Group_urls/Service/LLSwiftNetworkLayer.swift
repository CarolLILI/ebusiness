//
//  LLSwiftNetworkLayer.swift
//  Group_urls
//
//  Created by Aoli on 2022/10/13.
//

import Foundation
import Alamofire
import SwiftyJSON


//typealias 可以用来对已有的类型进行重命名, 可以对闭包进行重新命名，这样在做参数传递的时候更加清晰
public typealias Success = (_ result : Any) -> ()
public typealias Failure = (_ error : Any) -> ()


class LLSwiftNetworkLayer: NSObject {
    //单例
    static let shareInstance = LLSwiftNetworkLayer()
    //block
    var callBack_success: Success?
    var callBack_fail: Failure?
    
    
    // get request
    func getRequest(
        _ urlString: String,
        _ params:Parameters? = nil,
        _ Accept: String,
        success: @escaping Success,
        failure: @escaping Failure
    )
    {
        request(urlString, Accept, params, method: .get, success, failure)
    }
    
    //post request
    func postRequest(
        _ urlString: String,
        _ params:Parameters? = nil,
        _ Accept: String,
        success: @escaping Success,
        failure: @escaping Failure
    )
    {
        request(urlString, Accept, params, method: .post, success, failure)
    }
    
    
    //public request method
    private func request (
        _ urlString: String,
        _ Accept: String,
        _ params:Parameters? = nil,
        method: HTTPMethod,
        _ success: @escaping Success,
        _ failure: @escaping Failure
    )
    {
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 55
        
        let headers: HTTPHeaders = [
            "Content-Tyoe":"application/json",
            "Lang":"cn",
            "Accept": "application/json"
        ]

        manager.request(BASE_REL + urlString,
                        method: method,
                        parameters:params,
                        encoding: URLEncoding.default,
                        headers: headers).responseJSON { (response) in
            
//            print(response)
//            print(response.result)
            
            switch response.result {
            case .success(let json):
                success(json)
                break
            case .failure(let error):
                failure("error:\(error)")
                break
            }
        }
    
    }
    
    
}
