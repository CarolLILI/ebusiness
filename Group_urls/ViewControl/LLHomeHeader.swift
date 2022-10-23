//
//  LLHomeHeader.swift
//  Group_urls
//
//  Created by Aoli on 2022/9/30.
//

import UIKit
import Kingfisher
import SnapKit

class LLHomeHeader: UICollectionReusableView {
    var titleLable: UILabel?
    var iconArray = [UIImageView]()
    var titleArray = [UILabel]()
    var titleTextArray = ["排行版","购物指南","双11爆料季","白菜","0元试用"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func initView(){
        titleLable = UILabel.init()
        titleLable?.textColor = UIColor.red
        self.backgroundColor = UIColor.init(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        self.addSubview(titleLable!)
        
        let num = 5
        for i in 0 ..< num {
            var iconImage = UIImageView.init()
            iconImage.backgroundColor = UIColor.red
            iconImage.layer.cornerRadius = 10
            iconArray.append(iconImage)
            self.addSubview(iconImage)
            var title = UILabel.init()
            title.textColor = UIColor.init(red: 65/255, green: 65/255, blue: 65/255, alpha: 1)
            title.textAlignment = .center
            title.text = titleTextArray[i]
            title.font = UIFont.systemFont(ofSize: 15)
            self.addSubview(title)
            titleArray.append(title)
        }
        
    }
    
    func updataMode(){
//        titleLable?.text = "购物优惠搜索"
      
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLable?.snp.makeConstraints({ make in
            make.left.equalTo(0)
            make.top.equalTo(5)
            make.width.equalTo(UIScreen.main.bounds.size.width)
            make.height.equalTo(30)
        })
        var leftSize = 10.0
        var titleLeft = 0.0
        if iconArray.count != 0 {
            for iconElement in iconArray {
                iconElement.snp.makeConstraints { make in
                    make.left.equalTo(leftSize)
                    make.top.equalTo(20)
                    make.width.equalTo((UIScreen.main.bounds.size.width-100)/5)
                    make.height.equalTo(60)
                }
                leftSize += (UIScreen.main.bounds.size.width-100)/5 + 20
                
                let indexCell = iconArray.firstIndex(of: iconElement)
                let titleLb = titleArray[indexCell!]
                titleLb.snp.makeConstraints { make in
                    make.top.equalTo(iconElement.snp.bottom).offset(5)
                    make.left.equalTo(titleLeft)
                    make.width.equalTo((UIScreen.main.bounds.size.width)/5)
                }
                titleLeft += (UIScreen.main.bounds.size.width)/5
            }
        }

    }
}
