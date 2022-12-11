//
//  LLCollectionViewCell.swift
//  Group_urls
//
//  Created by Aoli on 2022/9/30.
//

import UIKit
import SnapKit
import Kingfisher

class LLCollectionViewCell: UICollectionViewCell {
    var titleLable: UILabel?
    var subTitleLb: UILabel?
    var priceTitle: UILabel?
    var subPriceTitle: UILabel?
    var imageView: UIImageView?
    var backGroundLayer: UIView?
    
    var lableHotArray = [UILabel]()
    
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
        imageView?.contentMode = .scaleToFill
        self.addSubview(imageView!)
        self.backgroundColor = UIColor.clear
        
        titleLable = UILabel.init()
        titleLable?.textColor = UIColor.init(red: 25/255.0, green: 25/255.0, blue: 25/255.0, alpha: 1)
        //仅仅显示2行，=0 时，显示无限行
        titleLable?.numberOfLines = 2
        titleLable?.lineBreakMode = .byTruncatingTail
        titleLable?.textAlignment = NSTextAlignment.left
        titleLable?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        titleLable?.font = UIFont.systemFont(ofSize: 18)
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
        priceTitle?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 2))
        self.addSubview(priceTitle!)
        
        subPriceTitle = UILabel.init()
        subPriceTitle?.textAlignment = NSTextAlignment.left
        subPriceTitle?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        subPriceTitle?.textColor = UIColor.init(red: 92/255.0, green: 92/255.0, blue: 92/255.0, alpha: 1)
        subPriceTitle?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(subPriceTitle!)
        
        
    }
    
    func updateModel(
        _ model: skuModel
    ){
//        titleLable?.text = model.sku_name
        priceTitle?.text = "¥\(model.price)元"
        subPriceTitle?.text = model.site_name
        let url = URL(string: model.image)
        imageView?.kf.setImage(with: url)
        //图文混合
        var textString = NSMutableAttributedString(string: model.sku_name)
        textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSMakeRange(0, textString.length))
        var textAttachment = NSTextAttachment()
        let imgView = UIImageView()
        imgView.kf.setImage(with: URL(string: BASE_REL + model.head_tag))
        textAttachment.image = imgView.image
        
        textAttachment.bounds = CGRectMake(0, 0, 30, 15)
        var textAttachmengString = NSAttributedString(attachment: textAttachment)
        textString.insert(textAttachmengString, at: 0)
        titleLable?.attributedText = textString
        
        //保证复用不会重复 
        for i in lableHotArray.count ..< model.tags.count {
            let lb = UILabel.init()
            lb.textAlignment = NSTextAlignment.center
            lb.textColor = "#FF4840".uicolor()
            lb.font = UIFont.systemFont(ofSize: 9)
            lb.layer.cornerRadius = 8
            lb.layer.borderColor = "#FF4840".uicolor().cgColor
            lb.layer.borderWidth = 1
            lb.textAlignment = .center
            lb.backgroundColor = UIColor.white
            lb.text = model.tags[i]
            lableHotArray.append(lb)
            self.addSubview(lb)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backGroundLayer?.snp.makeConstraints({ make in
            make.top.equalTo(5)
            make.left.equalTo(9)
            make.right.equalTo(-9)
            make.bottom.equalTo(5)
        })
        imageView?.snp.makeConstraints({ make in
            make.left.equalTo(25)
            make.top.equalTo(15)
            make.width.equalTo(100)
            make.bottom.equalTo(-10)
        })
        titleLable?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!.snp.right).offset(10)
            make.top.equalTo(20)
            //距离右边边距 10
            make.right.equalToSuperview().offset(-20)
        })
        subTitleLb?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!.snp.right).offset(15)
            make.top.equalTo(titleLable!.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-20)
        })
        priceTitle?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!.snp.right).offset(10)
            make.top.equalTo(subTitleLb!.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
        })

        subPriceTitle?.snp.makeConstraints({ make in
            make.left.equalTo(imageView!.snp.right).offset(10)
            make.top.equalTo(priceTitle!.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
        })
        
        
        
        var leftTabTitleLbl = 10.0
        for tabElement in lableHotArray {
            tabElement.snp.makeConstraints { make in
                make.left.equalTo(imageView!.snp.right).offset(leftTabTitleLbl)
                make.top.equalTo(titleLable!.snp.bottom).offset(3)
                make.height.equalTo(15)
                
                let text_size = getStrBoundRect(str: tabElement.text!, font: UIFont.systemFont(ofSize: 9), constrainedSize: CGSize(width: self.contentView.frame.width, height: 15))
                leftTabTitleLbl += text_size.width+25
                
                make.width.equalTo(text_size.width + 16)
            }
        }
        
    }
    
    func getStrBoundRect(str:String,font:UIFont, constrainedSize:CGSize,option:NSStringDrawingOptions=NSStringDrawingOptions.usesLineFragmentOrigin)->CGRect{
        let attr = [NSAttributedString.Key.font:font]
        let rect=str.boundingRect(with: constrainedSize, options: option, attributes: attr, context: nil)
        return rect
    }
}
