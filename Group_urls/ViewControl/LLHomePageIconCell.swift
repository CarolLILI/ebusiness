//
//  LLHomePageIconCell.swift
//  Group_urls
//
//  Created by Aoli on 2022/12/3.
//

import UIKit
import SnapKit
import Kingfisher

protocol iconHeaderClickDelegate: NSObjectProtocol {
    func sectionIconHeaderClick(index: Int)

}

class LLHomePageIconCell: UICollectionViewCell {
    
    weak var delegate: iconHeaderClickDelegate?
    
    var titleLable: UILabel?
    var iconImageBg: UIView?
    var iconArray = [UIImageView]()
    var titleArray = [UILabel]()
    var titleTextArray = ["天猫超市","京东超市","百亿补贴","淘宝推荐","多多优惠"]
    var imageNameArray = ["logosc1","logosc2","logosc3","logosc4","logosc5"]
    
    @objc func jumpPage(
       _ sender: UITapGestureRecognizer
    ){
        let tapLocation = sender.view
        self.delegate?.sectionIconHeaderClick(index:tapLocation!.tag)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLable?.snp.makeConstraints({ make in
            make.left.equalTo(0)
            make.top.equalTo(5)
            make.width.equalTo(UIScreen.main.bounds.size.width)
            make.height.equalTo(30)
        })
        
        iconImageBg?.snp.makeConstraints({ make in
            make.left.equalTo(9)
            make.top.equalTo(0)
            make.width.equalTo((UIScreen.main.bounds.size.width-18))
            make.height.equalTo(120)
        })
        var leftSize = 21.0
        if iconArray.count != 0 {
            for iconElement in iconArray {
                iconElement.snp.makeConstraints { make in
                    make.left.equalTo(leftSize)
                    make.top.equalTo(15)
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
    
    func initView(){
        
        titleLable = UILabel.init()
        titleLable?.textColor = UIColor.red
        self.addSubview(titleLable!)
        
        iconImageBg = UIView.init()
        iconImageBg!.backgroundColor = "#FFF3F0".uicolor()
        iconImageBg!.layer.cornerRadius = 10
        iconImageBg!.layer.masksToBounds = true
        self.addSubview(iconImageBg!)
        
        let num = 5
        for i in 0 ..< num {
            let iconImage = UIImageView.init()
            iconImage.backgroundColor = UIColor.clear
            iconImage.layer.cornerRadius = 10
            iconImage.layer.masksToBounds = true
            let imageName = imageNameArray[i]
            let image = UIImage(named: imageName)
            iconImage.image = image
            iconImage.contentMode = UIView.ContentMode.scaleAspectFit
            iconImage.tag = i + 1
            iconImage.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action:#selector(jumpPage(_:)))
            iconImage.addGestureRecognizer(tap)
            iconArray.append(iconImage)
            iconImageBg!.addSubview(iconImage)
            let title = UILabel.init()
            title.textColor = "#222222".uicolor()
            title.textAlignment = .center
            title.text = titleTextArray[i]
            title.font = UIFont.systemFont(ofSize: 15)
            iconImageBg!.addSubview(title)
            titleArray.append(title)
            }
        }
}
