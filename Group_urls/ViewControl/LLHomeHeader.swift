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
 
    func sectionTabBarClick(index: Int)
}


class LLHomeHeader: UICollectionReusableView {
    
    
    weak var delegate: sectionIconHeaderViewDelegate?
    
    var tabTitleArray = [UILabel]()
    var tabRedScorllArray = [UIView]()
    var tabTitle = ["实时热销","大额优惠","9.9专区"]

    
    override init(frame: CGRect) {
        super.init(frame: frame)


        updataMode()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
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

        
        
        var leftTabTitleLbl = 0.0
        for tabElement in tabTitleArray {
            tabElement.snp.makeConstraints { make in
                make.left.equalTo(leftTabTitleLbl)
                make.top.equalTo(18)
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
