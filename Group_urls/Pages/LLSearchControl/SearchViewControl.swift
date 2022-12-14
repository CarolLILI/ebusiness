//
//  SearchViewControl.swift
//  Group_urls
//
//  Created by Aoli on 2022/11/27.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SnapKit

import Toast_Swift

@available(iOS 13.0, *)
class SearchViewControl:BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView?
    let headerHeight: CGFloat = 30
    var globalData = [skuModel]()
    var parameter: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgImg?.isHidden = false
        self.baseTitle?.isHidden = true
        self.searchBarHeaderView?.isHidden = false
        
        screen_width = UIScreen.main.bounds.size.width
        screen_height = UIScreen.main.bounds.size.height
        setCollectionView()
        
        
        searchBarHeaderView?.clickSearchBtn = { [self](keyWord) ->() in
            print("block \(keyWord)")
            
            parameter = ["title":"\(keyWord)","pos": "1" ]
            requestData()
        }
        
        
    }
    
    override func backPreviousPages(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
    
    func setCollectionView(){
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: screen_width/2, height: screen_height/3)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        //设置行间隔距离
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout:layout)
        collectionView?.register(LLCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = UIColor.clear
        self.view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ make in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(UIDevice.xp_navigationFullHeight())
            make.bottom.equalTo(0)
        })

        collectionView?.es.addInfiniteScrolling(handler: {
            [unowned self] in
            //加载更多
//            requestData()
//            //加载更多事件成功，调用stop
//            collectionView!.es.stopLoadingMore()
            //通知暂无数据更新状态
            collectionView!.es.noticeNoMoreData()
        })
        
    }
    
    func requestData(){
        //获取数据
        let paramers = parameter
        let networkLayer = LLSwiftNetworkLayer.shareInstance
        networkLayer.getRequest(sku_list, (paramers as! Parameters), "") { [self] result in
            //请求成功
            let jsonData = JSON(result)["data"].rawValue
            let modelList = skuModelList(jsondata: JSON(rawValue: jsonData) ?? [])
            if globalData.count == 0 {
                globalData = modelList.skulist
            }
            else {
                globalData.append(contentsOf: modelList.skulist)
            }
            collectionView?.reloadData()
            //加载更多事件成功，调用stop
            collectionView!.es.stopLoadingMore()
            self.view.hideToastActivity()
//            print(result)
        } failure: { [self] error in
            self.view.hideToastActivity()
            //请求失败
            print(error)
            //加载更多事件成功，调用stop
            collectionView!.es.stopLoadingMore()
            self.view.makeToast("error: \(error)")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return globalData.count
    }
    // update cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LLCollectionViewCell
        var model = globalData[indexPath.row]
        cell.updateModel(model)
        return cell
    }

    // cell 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screen_width, height: 150.0)
    }

    // touch cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell!.layer.cornerRadius = 4
        cell?.backgroundColor = UIColor.clear
        
        let destination = productDetialControl()
        let model = globalData[indexPath.row]
        destination.selectModel = model
        self.navigationController?.pushViewController(destination, animated: true)
        
    }
}
