//
//  productDetailCell.swift
//  Group_urls
//
//  Created by Aoli on 2022/11/6.
//

import UIKit
import SnapKit
import Kingfisher

class productDetailCell: UICollectionViewCell {
    var titleLable: UILabel?
    var subTitleLb: UILabel?
    var priceTitle: UILabel?
    var subPriceTitle: UILabel?
    var imageView: UIImageView?
    var backGroundLayer: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func initView(){
        
        
        backGroundLayer = UIView.init()
        backGroundLayer?.backgroundColor = UIColor.white
        backGroundLayer?.layer.cornerRadius = 10
        self.addSubview(backGroundLayer!)
        
        imageView = UIImageView.init()
        imageView?.backgroundColor = UIColor.clear
        imageView?.contentMode = .scaleAspectFit
        self.addSubview(imageView!)
        self.backgroundColor = UIColor.clear

        
        titleLable = UILabel.init()
        titleLable?.textColor = UIColor.init(red: 25/255.0, green: 25/255.0, blue: 25/255.0, alpha: 1)
        //仅仅显示2行，=0 时，显示无限行
        titleLable?.numberOfLines = 2
        titleLable?.lineBreakMode = .byTruncatingTail
        titleLable?.textAlignment = NSTextAlignment.left
        titleLable?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        titleLable?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(titleLable!)
        
        subTitleLb = UILabel.init()
        subTitleLb?.textAlignment = NSTextAlignment.right
        subTitleLb?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        subTitleLb?.textColor = "#999999".uicolor()
        self.addSubview(subTitleLb!)
        
        priceTitle = UILabel.init()
        priceTitle?.textAlignment = NSTextAlignment.left
        priceTitle?.textColor = "#FF4840".uicolor()
        priceTitle?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        priceTitle?.font = UIFont(name: "DIN Alternate", size: 42)
        self.addSubview(priceTitle!)
        
        subPriceTitle = UILabel.init()
        subPriceTitle?.textAlignment = NSTextAlignment.left
        subPriceTitle?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        subPriceTitle?.textColor = "#FF4840".uicolor()
        subPriceTitle?.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(subPriceTitle!)
        
    }
    
    func updateModel(
        _ model: skuModel
    ){
        titleLable?.text = model.sku_name
        subTitleLb?.text = model.best_coupon_lable
        let url = URL(string: model.image)
        imageView?.kf.setImage(with: url,placeholder: UIImage(named: "goods_detial"))
        
        let frontStr = "¥"
        let subString = String(format: "%.2f", model.min_price)
        let attrStr = NSMutableAttributedString.init(string: frontStr,attributes: [NSAttributedString.Key.font: UIFont(name: "DIN Alternate", size: 24) as Any, NSAttributedString.Key.foregroundColor: "#FF4840".uicolor()])
        var attrSubString = NSMutableAttributedString(string: subString)
        attrSubString.insert(attrStr, at: 0)
        
        priceTitle?.attributedText = attrSubString
        
        let frontSuTitleStr = "原价"
        let subSubTitleStr = String(format: "%.2f", model.price)
        let attrSubTitleStr = NSMutableAttributedString.init(string: frontSuTitleStr, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: "#999999".uicolor()])
        var attrPriceStr = NSMutableAttributedString(string: subSubTitleStr)
        attrPriceStr.insert(attrSubTitleStr, at: 0)
        subPriceTitle?.attributedText = attrPriceStr
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backGroundLayer?.snp.makeConstraints({ make in
            make.top.equalTo(5)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(5)
        })
        
        imageView?.snp.makeConstraints({ make in
            make.left.equalTo(12)
            make.top.equalTo(0)
            make.width.equalTo(UIScreen.main.bounds.size.width - 24)
            make.height.equalTo(433/2)
        })
        
        titleLable?.snp.makeConstraints({ make in
            make.left.equalTo(12)
            make.top.equalTo(imageView!.snp.bottom).offset(25)
            make.right.equalToSuperview().offset(-12)
        })
        
        priceTitle?.snp.makeConstraints({ make in
            make.left.equalTo(titleLable!).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        })

        subPriceTitle?.snp.makeConstraints({ make in
            make.left.equalTo(priceTitle!.snp.right).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        })

        subTitleLb?.snp.makeConstraints({ make in
            make.right.equalToSuperview().offset(12)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        })

    }
}
