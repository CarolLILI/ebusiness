//
//  skuModel.swift
//  Group_urls
//
//  Created by Aoli on 2022/10/13.
//

import Foundation
import SwiftyJSON

class skuModelList: NSObject {
    var skulist = [skuModel]()
    
    init(jsondata: JSON) {
        let modelList = jsondata["list"].arrayValue
        for elements_model in modelList {
            let elems = JSON.init(elements_model)
            let skuModel = skuModel(jsondata: elems)
            skulist.append(skuModel)
        }
    }
    
}

class skuModel: NSObject {
    var sku_id = ""
    var sku_name = ""
    var price = 0.0
    var min_price = 0.0
    var site = ""
    
    var site_name = ""
    var couponsArray = [couponsModel]()
    var rec_reason = "" //领劵30元
    var discount_info = ""//9.0折
    var head_tag = ""
    var tags = [String]()
    var best_coupon_lable = ""
    var good_comments_rate = 0.0
    var detail_url = ""
    var coupon_url = ""

    var shopObj = shopModel.init(jsondata: [:])
    var image = ""
    var image_list = ""
    var jump_url = ""
    
    init(jsondata: JSON) {
        sku_id = jsondata["sku_id"].stringValue
        sku_name = jsondata["sku_name"].stringValue
        site_name = jsondata["site_name"].stringValue
        rec_reason = jsondata["rec_reason"].stringValue
        head_tag = jsondata["head_tag"].stringValue
        image = jsondata["image"].stringValue
        image_list = jsondata["image_list"].stringValue
        price = jsondata["price"].doubleValue
        min_price = jsondata["min_price"].doubleValue
        site = jsondata["site"].stringValue
        best_coupon_lable = jsondata["best_coupon_label"].stringValue
        good_comments_rate = jsondata["good_comments_rate"].doubleValue
        detail_url = jsondata["detail_url"].stringValue
        coupon_url = jsondata["coupon_url"].stringValue
        jump_url = jsondata["jump_url"].stringValue
        
        //json 中嵌套了数组
        let coupons = jsondata["coupons"].arrayValue
        for dic in coupons {
            let dicJson = JSON.init(dic)
            let couponsModel = couponsModel.init(jsonndata: dicJson)
            couponsArray.append(couponsModel)
        }
        //json 中嵌套了对象
        let shop = jsondata["shop"].stringValue
        shopObj = shopModel.init(jsondata: JSON(shop))
        
        //中部标签集
        let tags_lable = jsondata["tags"].arrayValue
        for elems in tags_lable {
            tags.append(elems.stringValue)
        }
        
    }
}

class couponsModel: NSObject {
    var bind_type = 0
    var discount = 0
    var link = ""
    var quota = 0
    var get_start_time = ""
    var get_end_time = ""
    var use_start_time = ""
    var use_end_time = ""
    var is_best = 0
    init(jsonndata: JSON){
        bind_type = jsonndata["bind_type"].intValue
        discount = jsonndata["discount"].intValue
        link = jsonndata["link"].stringValue
        quota = jsonndata["quota"].intValue
        get_start_time = jsonndata["get_start_time"].stringValue
        get_end_time = jsonndata["get_end_time"].stringValue
        use_start_time = jsonndata["use_start_time"].stringValue
        use_end_time = jsonndata["use_end_time"].stringValue
        is_best = jsonndata["is_best"].intValue
    }
}

class shopModel: NSObject {
    var shop_id = ""
    var shop_name = ""
    var shop_level = 0.0
    var shop_label = ""
    init(jsondata: JSON) {
        shop_id = jsondata["shop_id"].stringValue
        shop_name = jsondata["shop_name"].stringValue
        shop_level = jsondata["shop_level"].doubleValue
        shop_label = jsondata["shop_lebel"].stringValue
    }
}

class skuDetailModel: NSObject {
    var sku = skuModel.init(jsondata: [:])
    var recommend_list = [skuModel]()
    
    
    init(jsondata: JSON) {
        let modelList = jsondata["recommend_list"].arrayValue
        for elements_model in modelList {
            let elems = JSON.init(elements_model)
            let skuModel = skuModel(jsondata: elems)
            recommend_list.append(skuModel)
        }
        
        let model = jsondata["sku"]
        sku = skuModel.init(jsondata: JSON(model))
    }
    
}
