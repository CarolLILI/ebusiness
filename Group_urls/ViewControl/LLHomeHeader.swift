//
//  LLHomeHeader.swift
//  Group_urls
//
//  Created by Aoli on 2022/9/30.
//

import UIKit
import Kingfisher
import SnapKit

protocol sectionIconHeaderViewDelegate: NSObjectProtocol {
    func sectionIconHeaderClick(index: Int)
}

class LLHomeHeader: UICollectionReusableView {
    
    weak var delegate: sectionIconHeaderViewDelegate?
    
    var titleLable: UILabel?
    var iconArray = [UIImageView]()
    var titleArray = [UILabel]()
    var titleTextArray = ["天猫超市","京东超市","百亿补贴","淘宝推荐","多多优惠"]
    var imageNameArray = ["logosc1","logosc2","logosc3","logosc4","logosc5"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func jumpPage(
       _ sender: UITapGestureRecognizer
    ){
        let tapLocation = sender.view
        self.delegate?.sectionIconHeaderClick(index:tapLocation!.tag)
    }
    
    func updataMode(){
        titleLable = UILabel.init()
        titleLable?.textColor = UIColor.red
        self.backgroundColor = UIColor.init(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        self.addSubview(titleLable!)
        
        let num = 5
        for i in 0 ..< num {
            var iconImage = UIImageView.init()
            iconImage.backgroundColor = UIColor.clear
            iconImage.layer.cornerRadius = 10
//            iconImage.layer.borderWidth = 0.5
            iconImage.layer.masksToBounds = true
            var imageName = imageNameArray[i]
            let image = UIImage(named: imageName)
            iconImage.image = image
            iconImage.contentMode = UIView.ContentMode.scaleAspectFit
            iconImage.tag = i + 1
            iconImage.isUserInteractionEnabled = true
//            iconImage.backgroundColor = UIColor.red
            let tap = UITapGestureRecognizer.init(target: self, action:#selector(jumpPage(_:)))
            iconImage.addGestureRecognizer(tap)
            iconArray.append(iconImage)
            self.addSubview(iconImage)
            let title = UILabel.init()
            title.textColor = "#222222".uicolor()
            title.textAlignment = .center
            title.text = titleTextArray[i]
            title.font = UIFont.systemFont(ofSize: 11)
//            title.backgroundColor = UIColor.yellow
            self.addSubview(title)
            titleArray.append(title)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        titleLable?.snp.makeConstraints({ make in
            make.left.equalTo(0)
            make.top.equalTo(5)
            make.width.equalTo(UIScreen.main.bounds.size.width)
            make.height.equalTo(30)
        })
        var leftSize = 30.0;
        if iconArray.count != 0 {
            for iconElement in iconArray {
                iconElement.snp.makeConstraints { make in
                    make.left.equalTo(leftSize)
                    make.top.equalTo(28)
                    make.width.equalTo((UIScreen.main.bounds.size.width-180)/5)
                    make.height.equalTo(60)
                }
                leftSize += (UIScreen.main.bounds.size.width-180)/5+30;
                
                let indexCell = iconArray.firstIndex(of: iconElement)
                let titleLb = titleArray[indexCell!]
                titleLb.snp.makeConstraints { make in
                    make.top.equalTo(iconElement.snp.bottom).offset(5.0)
                    make.centerX.equalTo(iconElement)
//                    make.height.equalTo(36)
                    
                }
            }
        }

    }
}
