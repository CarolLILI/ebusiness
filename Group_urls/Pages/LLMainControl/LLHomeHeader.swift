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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func storeSelecTab(_ tabNum: String){
        let defaults = UserDefaults.standard
        defaults.setValue(tabNum, forKey: "home_page_tab_num")
    }
      
    func readLocalSelectTab() -> String{
        let defaults = UserDefaults.standard
        let value = defaults.string(forKey: "home_page_tab_num")
        
        if (value != nil) {
            return value as! String
        }
        return String()
    }
    
    func deleteLocalScorllData(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "home_page_tab_num")
    }

    
    @objc func updateTableView(
        _ sender: UITapGestureRecognizer
    ){
        let tapLocation = sender.view
        animalRedScroll(index: tapLocation!.tag)
        storeSelecTab(String(tapLocation!.tag))
        self.delegate?.sectionTabBarClick(index: tapLocation!.tag)
    }
    
    func animalRedScroll(index: Int){
        let tabElement = tabTitleArray[index]
        let redScroll = tabRedScorllArray[0]
        redScroll.center.x = tabElement.center.x
        
    }
    
    func updataMode(pageConfigurationList:homePageConfigurationList){
        let titleNum = pageConfigurationList.fp_tabs.count
        tabTitleArray.removeAll()
        tabRedScorllArray.removeAll()
        
        for i in tabTitleArray.count ..< titleNum {
            let skuConfiguraModel = pageConfigurationList.fp_tabs[i]
            let titleLb = UILabel.init()
            titleLb.textColor = "#222222".uicolor()
            titleLb.textAlignment = .center
            titleLb.text = skuConfiguraModel.name
            titleLb.font = UIFont(name: "PingFangTC-Semibold", size: 14)
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
        
        
        updateLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()


        
    }
    
    func updateLayout(){
        var leftTabTitleLbl = 0.0
        for tabElement in tabTitleArray {
            tabElement.snp.makeConstraints { make in
                make.left.equalTo(leftTabTitleLbl)
                make.top.equalTo(0)
                make.width.equalTo((UIScreen.main.bounds.size.width)/3)
                make.height.equalTo(38)
            }
            
            leftTabTitleLbl += (UIScreen.main.bounds.size.width)/3
            
            let indexCell = tabTitleArray.firstIndex(of: tabElement)
            let localStoreTabNum = readLocalSelectTab()
            let selecedIndex = Int(localStoreTabNum) ?? 0
            if indexCell == selecedIndex {
                let redScroll = tabRedScorllArray[0]
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
