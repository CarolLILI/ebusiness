//
//  LLRecommondHeader.swift
//  Group_urls
//
//  Created by Aoli on 2022/12/14.
//

import UIKit
import Kingfisher
import SnapKit

class LLRecommondHeader: UICollectionReusableView {
    
    var sectionHeader: UIView?
    var bgView: UIView?
    var lineView: UIView?
    var title: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updataMode()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func updataMode(){
        sectionHeader = UIView.init()
        sectionHeader!.backgroundColor = "#F1F1F1".uicolor()
        self.addSubview(sectionHeader!)
        
        bgView = UIView.init()
        bgView!.backgroundColor = UIColor.white
        sectionHeader!.addSubview(bgView!)
        
        lineView = UIView.init()
        lineView!.backgroundColor = "#999999".uicolor()
        bgView!.addSubview(lineView!)
        
        title = UILabel.init()
        title!.text = "为您推荐"
        title!.textColor = "#999999".uicolor()
        title!.font = UIFont.systemFont(ofSize: 14)
        title?.textAlignment = .center
        title?.backgroundColor = UIColor.white
        bgView!.addSubview(title!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sectionHeader?.snp.makeConstraints({ make in
            make.left.right.equalTo(0)
            make.width.equalTo(UIScreen.main.bounds.size.width)
            make.height.equalTo(75)
            make.top.equalTo(0)
        })
        
        bgView?.snp.makeConstraints({ make in
            make.top.equalTo(10)
            make.left.right.equalTo(0)
            make.width.equalTo(UIScreen.main.bounds.size.width)
            make.height.equalTo(65)
        })
        
        lineView?.snp.makeConstraints({ make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(bgView!.snp.centerY)
            make.width.equalTo(100)
            make.height.equalTo(0.5)
        })
        
        title?.snp.makeConstraints({ make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(bgView!.snp.centerY)
        })
    }
}
