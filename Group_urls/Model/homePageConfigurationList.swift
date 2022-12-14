//
// homePageConfigurationList.swift
//  Group_urls
//
//  Created by Aoli on 2022/12/8.
//

import Foundation
import SwiftyJSON

class skuConfObj: NSObject {
    var num = ""
    var name = ""
    var params = ""
    var icon = ""
    var model_id = ""
    var params_dict = skuParams.init(jsondata: [:])
    
    init(jsondata: JSON) {

        num = jsondata["num"].stringValue
        name = jsondata["name"].stringValue
        params = jsondata["params"].stringValue
        icon = jsondata["icon"].stringValue
        model_id = jsondata["model_id"].stringValue
        
        //json 中嵌套了对象
        let paramsD = jsondata["params_dict"].dictionaryValue
        params_dict = skuParams.init(jsondata: JSON(paramsD))
    }
    
}

class skuParams: NSObject {
    var elite_id = ""
    var site = ""
    var pos = ""
    init(jsondata: JSON) {

        elite_id = jsondata["elite_id"].stringValue
        site = jsondata["site"].stringValue
        pos = jsondata["pos"].stringValue
        
    }
}

class homePageConfigurationList: NSObject {
    var fp_channles = [skuConfObj]()
    var fp_tabs = [skuConfObj]()
    
    init(jsondata: JSON) {
        let modelList = jsondata["fp_channels"].arrayValue
        for elements_model in modelList {
            let elems = JSON.init(elements_model)
            let skuModel = skuConfObj(jsondata: elems)
            fp_channles.append(skuModel)
        }
        
        let model_tabs = jsondata["fp_tabs"].arrayValue
        for dic in model_tabs {
            let dicJson = JSON.init(dic)
            let couponsModel = skuConfObj(jsondata: dicJson)
            fp_tabs.append(couponsModel)
        }
    }
    
}

class homePageBannerList: NSObject {
    var total = ""
    var list = [banner]()
    init(jsondata: JSON){
        let modelList = jsondata["list"].arrayValue
        for elements_model in modelList {
            let elems = JSON.init(elements_model)
            let bannerModel = banner(jsondata: elems)
            list.append(bannerModel)
        }
    }
}

class banner: NSObject {
    var num = ""
    var act_id = ""
    var image = ""
    var title = ""
    var site = ""
    var jump_url = "" // 跳转web，和直达链接 功能一样
    var start_time = ""
    var end_time = ""
    var tag = ""
    
    init(jsondata: JSON) {
        num = jsondata["num"].stringValue
        act_id = jsondata["act_id"].stringValue
        image = jsondata["image"].stringValue
        title = jsondata["title"].stringValue
        site = jsondata["site"].stringValue
        jump_url = jsondata["jump_url"].stringValue
        start_time = jsondata["start_time"].stringValue
        end_time = jsondata["end_time"].stringValue
        tag = jsondata["tag"].stringValue
    }
}


