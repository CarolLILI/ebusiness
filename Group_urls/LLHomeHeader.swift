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
        self.backgroundColor = UIColor.yellow
        self.addSubview(titleLable!)
    }
    
    func updataMode(){
        titleLable?.text = "购物优惠搜索"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLable?.snp.makeConstraints({ make in
            make.left.equalTo(0)
            make.top.equalTo(5)
            make.width.equalTo(UIScreen.main.bounds.size.width)
            make.height.equalTo(30)
        })
    }
}
