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
        navigationController?.navigationBar.isHidden = false
        self.title = "多乐买"
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.init(red: 226/255, green: 36/255, blue: 35/255, alpha: 1),NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .semibold)]
        self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        self.view.backgroundColor = UIColor.init(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        screen_width = UIScreen.main.bounds.size.width
        screen_height = UIScreen.main.bounds.size.height - UIDevice.xp_navigationFullHeight()
        setCollectionView()
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

        collectionView?.register(LLHomeHeader.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UICollectionSectionHeader")
        
        collectionView!.es.addPullToRefresh {
            [unowned self] in
            //刷新相关的事件

            updateOldModeData()
        }
        
        collectionView?.es.addInfiniteScrolling(handler: {
            [unowned self] in
            //加载更多
            updateModelData()

        })
        
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firstModel.count
    }
    // cell 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screen_width, height: screen_height)
    }
    
    // update cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! productDetailCell
        let model = firstModel[indexPath.row]
        cell.updateModel(model)
        return cell
    }
    
    
    
}
