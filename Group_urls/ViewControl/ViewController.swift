//
//  ViewController.swift
//  Group_urls
//
//  Created by Aoli on 2022/8/11.
//

import UIKit
//swift 第三方库：（https://wenku.baidu.com/view/693d222eeb7101f69e3143323968011ca300f7f3.html）
//网络请求库：Alamofire （https://www.cnblogs.com/lfri/p/14067146.html）
//请求数据解析库：https://github.com/SwiftyJSON/SwiftyJSON (https://www.jianshu.com/p/288b3d15cfde)
//sdwebimage 库：Kingfisher（https://github.com/onevcat/Kingfisher）
//SnapKit 自动布局：https://github.com/SnapKit/SnapKit
//ESPullToRefresh 上下拉刷新：https://www.jianshu.com/p/c3f2b8ef9c4b
//网络请求的弹窗 https://github.com/scalessec/Toast-Swift
import Alamofire
import SwiftyJSON
import SnapKit
import ESPullToRefresh
import Toast_Swift


@available(iOS 13.0, *)
class ViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,homeHeaderViewDelegate {
    var screen_width:CGFloat!
    var screen_height:CGFloat!
    var collectionView: UICollectionView?
    let headerHeight: CGFloat = 30
    var globalData = [skuModel]()
    
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
        screen_height = UIScreen.main.bounds.size.height
        setCollectionView()
        requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if globalData.count == 0 {
            requestData()
        }
        
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
        layout.minimumLineSpacing = 15
        
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
//            make.bottom.equalTo(-UIDevice.xp_tabBarFullHeight())
            make.bottom.equalTo(0)
        })

        collectionView?.register(LLHomeHeader.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UICollectionSectionHeader")
        
        collectionView!.es.addPullToRefresh {
            [unowned self] in
            //刷新相关的事件
            
            //刷新成功，设置completion自动重制footer 的状态
            collectionView!.es.stopPullToRefresh()
            // 设置ignoreFotter 来处理不需要显示footer
        }
        
        collectionView?.es.addInfiniteScrolling(handler: {
            [unowned self] in
            //加载更多
            requestData()
//            //加载更多事件成功，调用stop
//            collectionView!.es.stopLoadingMore()
            //通知暂无数据更新状态
//            collectionView!.es.noticeNoMoreData()
        })
        
    }
    
    @objc func updateData(){
        // 下拉刷新，更新下一页面的数据
    }
    
    func requestData(){
        self.view.makeToastActivity(.center)
        //获取数据
        let paramers = ["elite_id":1,"site":"jd"] as [String : Any]
        let networkLayer = LLSwiftNetworkLayer.shareInstance
        networkLayer.getRequest(homepage_product_recommend, paramers, "") { [self] result in
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
//            self.view.makeToast("error: \(error)")
            
           
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
    // header的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
         return CGSize(width: screen_width, height: 130)
     }
    // cell 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screen_width, height: 150.0)
    }
    // update header view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var llHearder = LLHomeHeader()
        if kind == UICollectionView.elementKindSectionHeader {
            llHearder = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UICollectionSectionHeader", for: indexPath) as! LLHomeHeader
        }
        llHearder.delegate = self
        llHearder.isUserInteractionEnabled = true
        llHearder.updataMode()
        return llHearder
    }
    // touch cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell!.layer.cornerRadius = 4
        cell?.backgroundColor = UIColor.clear
        
        let destination = productListViewControl()
        //仅仅暂时措施
        var num = indexPath.row % 4 + 1
        
        destination.parameter = ["":"","elite_id":num,"site":"jd"]
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell!.layer.cornerRadius = 4
//        cell?.backgroundColor = UIColor.clear
//    }
    
    func homeHeaderViewClick(index: Int) {
        let destination = productListViewControl()
        //仅仅暂时措施
        var num = index
        if index == 5 {
            num = 1
        }
        destination.parameter = ["elite_id":num,"site":"jd"]
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
}

