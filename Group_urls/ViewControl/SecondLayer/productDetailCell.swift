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
        titleLable?.font = UIFont.systemFont(ofSize: 25)
        self.addSubview(titleLable!)
        
        subTitleLb = UILabel.init()
        subTitleLb?.textAlignment = NSTextAlignment.left
        subTitleLb?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        subTitleLb?.textColor = UIColor.init(red: 92/255.0, green: 92/255.0, blue: 92/255.0, alpha: 1)
        self.addSubview(subTitleLb!)
        
        priceTitle = UILabel.init()
        priceTitle?.textAlignment = NSTextAlignment.left
        priceTitle?.textColor = UIColor.init(red: 225/255.0, green: 45/255.0, blue: 45/255.0, alpha: 1)
        priceTitle?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        priceTitle?.font = UIFont.systemFont(ofSize: 35, weight: UIFont.Weight(rawValue: 2))
        self.addSubview(priceTitle!)
        
        subPriceTitle = UILabel.init()
        subPriceTitle?.textAlignment = NSTextAlignment.left
        subPriceTitle?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        subPriceTitle?.textColor = UIColor.init(red: 92/255.0, green: 92/255.0, blue: 92/255.0, alpha: 1)
        subPriceTitle?.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(subPriceTitle!)
        
    }
    
    func updateModel(
        _ model: skuModel
    ){
        titleLable?.text = model.sku_name
        priceTitle?.text = "预估到手¥\(model.min_price)"
        subTitleLb?.text = model.best_coupon_lable
        subPriceTitle?.text = "原价\(model.price)"
        let url = URL(string: model.image)
        imageView?.kf.setImage(with: url)
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
            make.left.equalTo(15)
            make.top.equalTo(5)
            make.width.equalTo(UIScreen.main.bounds.size.width - 30)
            make.height.equalTo((UIScreen.main.bounds.size.height-UIDevice.xp_navigationFullHeight())/2)
        })
        
        priceTitle?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!).offset(10)
            make.top.equalTo(imageView!.snp.bottom).offset(10)
        })

        subPriceTitle?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!).offset(10)
            make.top.equalTo(priceTitle!.snp.bottom).offset(10)
        })


        titleLable?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!).offset(10)
            make.top.equalTo(subPriceTitle!.snp.bottom).offset(20)
            //距离右边边距 10
            make.right.equalToSuperview().offset(-50)
        })
        subTitleLb?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!).offset(10)
            make.top.equalTo(titleLable!.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
        })

    }
}
