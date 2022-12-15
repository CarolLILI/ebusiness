//
//  productDetialControl.swift
//  Group_urls
//
//  Created by Aoli on 2022/11/5.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SnapKit
import Toast_Swift


@available(iOS 13.0, *)
class productDetialControl:  BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    var collectionView: UICollectionView?
    var globalData = [skuModel]()
    var firstModel = [skuModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.bgImg?.isHidden = false
        self.baseTitle?.text = "商品详情"
        screen_width = UIScreen.main.bounds.size.width
        screen_height = UIScreen.main.bounds.size.height - UIDevice.xp_navigationFullHeight()
        setCollectionView()
        self.view.backgroundColor = UIColor.white
//        requestData()
    }
    
    func setCollectionView(){
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: screen_width/2, height: screen_height/3)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        //设置行间隔距离
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout:layout)
        collectionView?.register(productDetailCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.register(LLCollectionViewCell.self, forCellWithReuseIdentifier: "listCell")
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ make in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(UIDevice.xp_navigationFullHeight())
            make.bottom.equalTo(0)
        })

        collectionView?.register(LLRecommondHeader.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UICollectionSectionHeader")
        
        
//        collectionView!.es.addPullToRefresh {
//            [unowned self] in
//            //刷新相关的事件
//
//            updateOldModeData()
//        }
        
        collectionView?.es.addInfiniteScrolling(handler: {
            [unowned self] in
            //加载更多
//            updateModelData()

        })
        
        let bottomView = UIView.init()
        bottomView.backgroundColor = UIColor.white
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.width.equalTo(screen_width)
            make.height.equalTo(82)
            make.left.equalTo(0)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        let shareButton = UILabel.init()
        shareButton.text = "去分享"
        shareButton.textAlignment = .center
        shareButton.textColor = "#666666".uicolor()
        shareButton.font = UIFont.systemFont(ofSize: 12)
        shareButton.layer.cornerRadius = 8
        shareButton.layer.borderWidth = 1
        shareButton.layer.borderColor = "#999999".uicolor().cgColor
        bottomView.addSubview(shareButton)
        shareButton.isUserInteractionEnabled = true
        
        let jumpLinkButton = UILabel.init()
        jumpLinkButton.text = "直达分享"
        jumpLinkButton.textAlignment = .center
        jumpLinkButton.textColor = UIColor.white
        jumpLinkButton.font = UIFont.systemFont(ofSize: 12)
        jumpLinkButton.layer.cornerRadius = 8
        jumpLinkButton.layer.borderWidth = 1
        jumpLinkButton.layer.masksToBounds = true
        jumpLinkButton.layer.borderColor = "#FF4840".uicolor().cgColor
        jumpLinkButton.backgroundColor = "#FF4840".uicolor()
        bottomView.addSubview(jumpLinkButton)
        
        shareButton.snp.makeConstraints { make in
            make.left.equalTo(18)
            make.width.equalTo((screen_width - 18 - 18 - 12)/2)
            make.height.equalTo(34)
            make.top.equalTo(8)
        }
        
        jumpLinkButton.snp.makeConstraints { make in
            make.left.equalTo(shareButton.snp.right).offset(12)
            make.width.equalTo((screen_width - 18 - 18 - 12)/2)
            make.height.equalTo(34)
            make.top.equalTo(8)
        }
        
        
    }
    
    func updateModelData(){
        var index = globalData.firstIndex(of: firstModel.first!)
        if globalData.count >= (index! + 1) {
            firstModel = [globalData[index! + 1]]
        } else {
            //通知暂无数据更新状态
            collectionView!.es.noticeNoMoreData()
        }
        collectionView?.reloadData()
        collectionView!.es.stopLoadingMore()
    }
    
    func updateOldModeData(){
        var index = globalData.firstIndex(of: firstModel.first!)
        if globalData.count >= (index! - 1) && (index!-1) >= 0{
            firstModel = [globalData[index! - 1]]
        }
        collectionView?.reloadData()
        collectionView!.es.stopPullToRefresh()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else {
            return globalData.count
        }
    }
    // header的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if section == 1 {return CGSize(width: screen_width, height: 75)}
        return CGSize(width:0, height: 0)
     }
    
    // update section header view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var sectionIconHeader = UICollectionReusableView()
        if indexPath.section == 1 {
            if kind == UICollectionView.elementKindSectionHeader {
                var sectionIconHeaderView = LLRecommondHeader(frame: CGRectZero)
                sectionIconHeaderView  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UICollectionSectionHeader", for: indexPath) as! LLRecommondHeader

                return sectionIconHeaderView
            }
        }
        return sectionIconHeader
    }
    
    // cell 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: screen_width, height: 130.0)
        }
        return CGSize(width: screen_width, height: 724.0/2)
    }
    
    // update cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! productDetailCell
            let model = firstModel[indexPath.row]
            cell.updateModel(model)
            return cell
        }
        else {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! LLCollectionViewCell
            let model = globalData[indexPath.row]
            cell.updateModel(model)
            return cell
        }

    }
    
    
    
}
