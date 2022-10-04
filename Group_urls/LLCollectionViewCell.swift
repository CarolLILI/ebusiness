//
//  LLCollectionViewCell.swift
//  Group_urls
//
//  Created by Aoli on 2022/9/30.
//

import UIKit
import SnapKit

class LLCollectionViewCell: UICollectionViewCell {
    var titleLable: UILabel?
    var subTitleLb: UILabel?
    var priceTitle: UILabel?
    var subPriceTitle: UILabel?
    var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func initView(){

        imageView = UIImageView.init()
        imageView?.backgroundColor = UIColor.red
        imageView?.contentMode = .scaleAspectFit
        self.addSubview(imageView!)
        self.backgroundColor = UIColor.green
        
        titleLable = UILabel.init()
        titleLable?.backgroundColor = UIColor.yellow
        titleLable?.layer.cornerRadius = 4
        titleLable?.layer.borderWidth = 0.5
        //仅仅显示2行，=0 时，显示无限行
        titleLable?.numberOfLines = 2
        titleLable?.lineBreakMode = .byTruncatingTail
        titleLable?.textAlignment = NSTextAlignment.left
        titleLable?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.addSubview(titleLable!)
        
        subTitleLb = UILabel.init()
        subTitleLb?.textAlignment = NSTextAlignment.left
        subTitleLb?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.addSubview(subTitleLb!)
        
        priceTitle = UILabel.init()
        priceTitle?.textColor = UIColor.red
        priceTitle?.textAlignment = NSTextAlignment.left
        priceTitle?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.addSubview(priceTitle!)
        
        subPriceTitle = UILabel.init()
        subPriceTitle?.textAlignment = NSTextAlignment.left
        subPriceTitle?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.addSubview(subPriceTitle!)
        
    }
    
    func updateModel(){
        titleLable?.text = "京东PLUS会员京东PLUS会员京东PLUS会员"
        priceTitle?.text = "1370元（双重折扣）"
        subTitleLb?.text = "精选 低于日常价格"
        subPriceTitle?.text = "京东｜09:58"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.snp.makeConstraints({ make in
            make.left.equalTo(10)
            make.top.equalTo(15)
            make.width.equalTo(100)
            make.bottom.equalTo(-10)
        })
        titleLable?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!.snp.right).offset(10)
            make.top.equalTo(10)
            //距离右边边距 10
            make.right.equalToSuperview().offset(-10)
        })
        subTitleLb?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!.snp.right).offset(10)
            make.top.equalTo(titleLable!.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
        })
        priceTitle?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!.snp.right).offset(10)
            make.top.equalTo(subTitleLb!.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
        })

        subPriceTitle?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!.snp.right).offset(10)
            make.top.equalTo(priceTitle!.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
        })
    }
}
