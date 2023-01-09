//
//  LLSwiftNetworkLayer.swift
//  Group_urls
//
//  Created by Aoli on 2022/10/13.
//

import Foundation
import Alamofire
import SwiftyJSON
import AdSupport


//typealias 可以用来对已有的类型进行重命名, 可以对闭包进行重新命名，这样在做参数传递的时候更加清晰
public typealias Success = (_ result : Any) -> ()
public typealias Failure = (_ error : Any) -> ()


class LLSwiftNetworkLayer: NSObject {
    //单例
    static let shareInstance = LLSwiftNetworkLayer()
    //block
    var callBack_success: Success?
    var callBack_fail: Failure?
    
    func getNowTimeStamp()->String {
        let formatter = DateFormatter.init()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        
        let timeZone = NSTimeZone(name: "Asia/Shanghai")
        formatter.timeZone = timeZone as TimeZone?
        
        let dateNow = NSDate()
        
        let timeStamp = String(format: "%ld", dateNow.timeIntervalSince1970)
        
        return timeStamp
        
    }
    
    func getVersionName()->String {
        let infoDictionary = Bundle.main.infoDictionary
        let appVersion = infoDictionary!["CFBundleShortVersionString"]
        let appBuild = infoDictionary!["CFBundleVersion"]
        let versionName = String(format: "%@.%@", appVersion as! CVarArg, appBuild as! CVarArg)
        return versionName
    }
    
    func getIDFA()->String {
        let addid = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        
        return addid
    }
    
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
        _ params:Parameters? = [:],
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
        
        var wholeParams = [
            "os":"ios",
            "imei":getIDFA(),
            "st": getNowTimeStamp(),//时间戳
            "sn":"",
            "v":getVersionName(),
            "uid":"",
            "utk":""
        ]
        
        var mergeParams = params
        
        for (key, value) in wholeParams {
            mergeParams![key] = value
        }
        
        print("......whole params: %@", mergeParams as Any)
        

        manager.request(BASE_REL + urlString,
                        method: method,
                        parameters: mergeParams,
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
