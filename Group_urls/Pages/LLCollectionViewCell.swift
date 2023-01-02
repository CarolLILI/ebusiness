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
    var skuModels: skuModel?
    
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
        priceTitle?.font = UIFont(name: "PingFang Medium", size: 14)
        self.addSubview(priceTitle!)
        
        subPriceTitle = UILabel.init()
        subPriceTitle?.textAlignment = NSTextAlignment.left
        subPriceTitle?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        subPriceTitle?.textColor = UIColor.init(red: 92/255.0, green: 92/255.0, blue: 92/255.0, alpha: 1)
        subPriceTitle?.font = UIFont(name: "PingFang SC Regular", size: 11)
        self.addSubview(subPriceTitle!)
    
    }
    
    func updateModel(
        _ model: skuModel
    ){
        skuModels = model
//        titleLable?.text = model.sku_name
        priceTitle?.text = String(format: "¥%.2f元", model.min_price)
        subPriceTitle?.text = model.site_name
        let url = URL(string: model.image)
        imageView?.kf.setImage(with: url, placeholder: UIImage(named: "list_img"))
        //图文混合，图片+文字
        var textString = NSMutableAttributedString(string: model.sku_name)
        textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSMakeRange(0, textString.length))
        textString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "PingFangTC-Semibold", size: 15) as Any, range: NSMakeRange(0, textString.length))
        
//        let imgView = UIImageView()
//        imgView.kf.setImage(with: URL(string: BASE_REL + model.head_tag))
//        textAttachment.image = imgView.image
        

        
        //图文很合，文字 + 文字
//        let attrStr = NSMutableAttributedString(string: model.head_tag)
//        attrStr.addAttributes([NSAttributedString.Key.backgroundColor: "#FF4840".uicolor(), NSAttributedString.Key.font:UIFont(name: "YouSheBiaoTiHei", size: 12) as Any,NSAttributedString.Key.foregroundColor: UIColor.white], range: NSMakeRange(0, attrStr.length))
        
        
        let attrLb = UILabel.init()
        attrLb.text = model.head_tag
        //swift 计算字符串长度
        let text_size = getStrBoundRect(str: attrLb.text!, font: UIFont(name: "YouSheBiaoTiHei", size: 14)!, constrainedSize: CGSize(width: self.contentView.frame.width, height: 16))
        let frame_width = text_size.width + 10
        
        attrLb.frame = CGRectMake(0, 0, CGFloat(frame_width), 16)
        attrLb.font = UIFont(name: "YouSheBiaoTiHei", size: 14)
        attrLb.textColor = UIColor.white
        attrLb.layer.cornerRadius = 3
        attrLb.clipsToBounds = true
        attrLb.textAlignment = .center
        attrLb.backgroundColor = "#FF4840".uicolor()
        attrLb.contentMode = .scaleAspectFit

        // 服务器返回的文字，文字转换为image，放在字符串前面的标签
        var textAttachment = NSTextAttachment()
        textAttachment.image = attrLb.asImage()

        let attrLb_length = model.head_tag.count > 0 ? attrLb.frame.width: 0
        textAttachment.bounds = CGRectMake(0, -2.5, attrLb_length,16)
        var textAttachmengString = NSAttributedString(attachment: textAttachment)
        textString.insert(textAttachmengString, at: 0)
        titleLable?.attributedText = textString
        

        //保证复用不会重复
        
        if lableHotArray.count < model.tags.count {
            for i in 0 ..< model.tags.count {
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
                lb.tag = i
                lableHotArray.append(lb)
                self.addSubview(lb)
            }
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
        if skuModels!.tags.count > 0 && lableHotArray.count <= (skuModels?.tags.count)!{
            for i in 0 ..< lableHotArray.count {
                let tabElement = lableHotArray[i]
                let text_size = getStrBoundRect(str: tabElement.text!, font: UIFont.systemFont(ofSize: 9), constrainedSize: CGSize(width: self.contentView.frame.width, height: 15))
                

                tabElement.snp.makeConstraints { make in
                    make.left.equalTo(imageView!.snp.right).offset(leftTabTitleLbl)
                    make.top.equalTo(titleLable!.snp.bottom).offset(3)
                    make.height.equalTo(15)
                    make.width.equalTo(text_size.width + 16)
                    
                }
                
                leftTabTitleLbl += text_size.width+16 + 5
            }
        }

        
    }
    
    func getStrBoundRect(str:String,font:UIFont, constrainedSize:CGSize,option:NSStringDrawingOptions=NSStringDrawingOptions.usesLineFragmentOrigin)->CGRect{
        let attr = [NSAttributedString.Key.font:font]
        let rect=str.boundingRect(with: constrainedSize, options: option, attributes: attr, context: nil)
        return rect
    }
}


