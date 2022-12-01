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
    
    func sectionTabBarClick(index: Int)
}


class LLHomeHeader: UICollectionReusableView {
    
    weak var delegate: sectionIconHeaderViewDelegate?
    
    var titleLable: UILabel?
    var iconArray = [UIImageView]()
    var titleArray = [UILabel]()
    var tabTitleArray = [UILabel]()
    var tabRedScorllArray = [UIView]()
    var titleTextArray = ["天猫超市","京东超市","百亿补贴","淘宝推荐","多多优惠"]
    var imageNameArray = ["logosc1","logosc2","logosc3","logosc4","logosc5"]
    var tabTitle = ["实时热销","大额优惠","9.9专区"]
    var iconImageBg: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updataMode()
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
    @objc func updateTableView(
        _ sender: UITapGestureRecognizer
    ){
        let tapLocation = sender.view
        animalRedScroll(index: tapLocation!.tag)
        self.delegate?.sectionTabBarClick(index: tapLocation!.tag)
    }
    
    func animalRedScroll(index: Int){
        let tabElement = tabTitleArray[index]
        let redScroll = tabRedScorllArray[0]
        redScroll.center.x = tabElement.center.x
    }
    
    func updataMode(){
        
        self.backgroundColor = "#FFFAF9".uicolor()
        
        titleLable = UILabel.init()
        titleLable?.textColor = UIColor.red
        self.backgroundColor = UIColor.init(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
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
        
        let titleNum = 3
        for i in 0 ..< titleNum {
            let titleLb = UILabel.init()
            titleLb.textColor = "#222222".uicolor()
            titleLb.textAlignment = .center
            titleLb.text = tabTitle[i]
            titleLb.font = UIFont.systemFont(ofSize: 14)
            titleLb.textAlignment = .center
            titleLb.backgroundColor = "#FFFFFF".uicolor()
            self.addSubview(titleLb)
            tabTitleArray.append(titleLb)
            titleLb.isUserInteractionEnabled = true
            titleLb.tag = i
            let tap = UITapGestureRecognizer.init(target: self, action:#selector(updateTableView(_:)))
            titleLb.addGestureRecognizer(tap)
            
            if tabRedScorllArray.count == 0 {
                let redScroll = UIView.init()
                redScroll.backgroundColor = "#FF4840".uicolor()
                self.addSubview(redScroll)
                tabRedScorllArray.append(redScroll)
            }

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
        
        iconImageBg?.snp.makeConstraints({ make in
            make.left.equalTo(9)
            make.top.equalTo(28)
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
        
        var leftTabTitleLbl = 0.0
        for tabElement in tabTitleArray {
            tabElement.snp.makeConstraints { make in
                make.left.equalTo(leftTabTitleLbl)
                make.top.equalTo(iconImageBg!.snp.bottom).offset(18)
                make.width.equalTo((UIScreen.main.bounds.size.width)/3)
                make.height.equalTo(38)
                
                leftTabTitleLbl += (UIScreen.main.bounds.size.width)/3
                
                let indexCell = tabTitleArray.firstIndex(of: tabElement)
                if indexCell == 0 {
                    let redScroll = tabRedScorllArray[indexCell!]
                    redScroll.snp.makeConstraints { make in
                        make.top.equalTo(tabElement.snp.bottom)
                        make.centerX.equalTo(tabElement)
                        make.width.equalTo(18)
                        make.height.equalTo(3)
                    }
                }

                
            }
        }
        

    }
}
