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

struct defaultsKeys {
    static let homePage_Configuration = "homePage_Configuration"
    static let homePage_Banner = "homePage_Banner"
}

@available(iOS 13.0, *)
class ViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,sectionIconHeaderViewDelegate,LLSearchBarDelegate,iconHeaderClickDelegate,bannerClickDelegate {
    

    var collectionView: UICollectionView?
    var sectionSearchBarHeaderView: LLSearchBar?
    let headerHeight: CGFloat = 30
    var globalData = [skuModel]()
    var banner :homePageBannerList?
    var homeConfig : homePageConfigurationList?
    var requesrParam: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //swift 背景渐变
        let layer1 = CAGradientLayer()
        layer1.colors = [UIColor(red: 1, green: 0.282, blue: 0.29, alpha: 1).cgColor,
                         UIColor(red: 1, green: 0.91, blue: 0.873, alpha: 0.49).cgColor,
                         UIColor(red: 1, green: 0.938, blue: 0.873, alpha: 0).cgColor,
                         UIColor(red: 1, green: 0.939, blue: 0.874, alpha: 1).cgColor]
        layer1.locations = [0,0.89,1,1]
        layer1.startPoint = CGPoint(x: 0.5, y: 0)
        layer1.endPoint = CGPoint(x: 0.5, y: 1)
        layer1.bounds = CGRectMake(0, 0, UIScreen.main.bounds.size.width, 343)
        layer1.position = CGPoint(x: self.view.center.x, y: self.view.center.y-UIScreen.main.bounds.size.height/2+70+UIDevice.xp_navigationFullHeight())
        self.view.layer.addSublayer(layer1)
        
        self.bgImg?.isHidden = true

        screen_width = UIScreen.main.bounds.size.width
        screen_height = UIScreen.main.bounds.size.height
        searchBar()
        setCollectionView()
        requestBanner()
        requestConfiguration()
        setConfiguration()
        
        requesrParam = ["elite_id":1,"site":"jd","pos":1] as NSDictionary
        requestData()
        
    }
    func setConfiguration(){
        let json_banner = readLocalBanner()
        banner = homePageBannerList(jsondata: JSON(rawValue: json_banner) ?? [])
        
        let json_config = readLocalConfiguration()
        homeConfig = homePageConfigurationList(jsondata: JSON(rawValue: json_config) ?? [])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        if globalData.count == 0 {
            requestData()
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
    
    func setStatusBarColor(color:UIColor){
        let statusBarWindow: UIWindow = UIApplication.shared.value(forKey: "statusBarWindow") as! UIWindow
        let statusView:UIView = statusBarWindow.value(forKey: "statusBar") as!UIView
        statusView.backgroundColor = color
    }
    
    func searchBar(){
        sectionSearchBarHeaderView = LLSearchBar()
        sectionSearchBarHeaderView!.delegate = self
        sectionSearchBarHeaderView!.isUserInteractionEnabled = true
        sectionSearchBarHeaderView!.updataMode()
        self.view.addSubview(sectionSearchBarHeaderView!)
        
        sectionSearchBarHeaderView?.snp.makeConstraints({ make in
            make.top.equalTo(UIDevice.xp_navigationBarHeight())
            make.left.equalTo(0)
            make.width.equalTo(screen_width)
            make.height.equalTo(75)
        })
    }
    
    func setCollectionView(){
            
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: screen_width/2, height: screen_height/3)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionFootersPinToVisibleBounds = true
        //设置行间隔距离
        layout.minimumLineSpacing = 15
        
        collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout:layout)
        collectionView?.register(LLCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.register(LLHomePageIconCell.self, forCellWithReuseIdentifier: "iconCell")
        collectionView?.register(LLHomePageBannerCell.self, forCellWithReuseIdentifier: "bannerCell")
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = UIColor.clear
        self.view.addSubview(collectionView!)

        
        collectionView?.snp.makeConstraints({ make in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(sectionSearchBarHeaderView!.snp.bottom)
            make.bottom.equalTo(0)
        })

        collectionView?.register(LLHomeHeader.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UICollectionSectionHeader")
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
        
        let networkLayer = LLSwiftNetworkLayer.shareInstance
        networkLayer.getRequest(favor_list, (requesrParam as! Parameters), "") { [self] result in
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
    
    func requestConfiguration(){
        let paramers = ["pos":1] as [String : Any]
        let networkLayer = LLSwiftNetworkLayer.shareInstance
        networkLayer.getRequest(home_page_configuration, paramers,"") { [self] result in
            let jsonData = JSON(result)["data"].rawValue
            storageHomeConfiguration(jsonData as! NSDictionary)
            
        } failure: { error in
            
        }
    }
    
    func requestBanner(){
        let paramers = ["pos":1] as [String : Any]
        let networkLayer = LLSwiftNetworkLayer.shareInstance
        networkLayer.getRequest(home_page_banner, paramers,"") { [self] result in
            let jsonData = JSON(result)["data"].rawValue
            storeHomeBanner(jsonData as! NSDictionary)
            
        } failure: { error in
            
        }
    }
    
    
    func storageHomeConfiguration(_ jsonString: NSDictionary){
        let defaults = UserDefaults.standard
        defaults.setValue(jsonString, forKey: defaultsKeys.homePage_Configuration)
    }
    
    func storeHomeBanner(_ jsonString: NSDictionary){
        let defaults = UserDefaults.standard
        defaults.setValue(jsonString, forKey: defaultsKeys.homePage_Banner)
    }
    
    func readLocalConfiguration() -> NSDictionary{
        let defaults = UserDefaults.standard
        let value = defaults.dictionary(forKey: defaultsKeys.homePage_Configuration)
        
        if (value != nil) {
            return value as! NSDictionary
        }
        return NSDictionary()
    }
    
    func readLocalBanner() -> NSDictionary{
        let defaults = UserDefaults.standard
        let value = defaults.dictionary(forKey: defaultsKeys.homePage_Banner)
        if (value != nil) {
            return value as! NSDictionary
        }
        return NSDictionary()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
//        if banner!.list.count > 0 || (homeConfig?.fp_channles.count)!>0{
//            return 2
//        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if section == 0{
            
            if banner!.list.count > 0 && homeConfig!.fp_channles.count > 0{
                return 2
            }
            else if banner!.list.count > 0{
                return 1
            }
            else if homeConfig!.fp_channles.count > 0{
                return 1
            }
            else {
                return 1
            }
        }
        else {
            return globalData.count

        }
    }
    // update cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 && banner!.list.count > 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! LLHomePageBannerCell
                cell.delegate = self
                cell.bannerModelList = banner
                cell.pagerView?.reloadData()
                return cell
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! LLHomePageIconCell
                cell.delegate = self
                cell.updateModel(configuraModel: homeConfig!)
                return cell
            }

        }
        else {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LLCollectionViewCell
            let model = globalData[indexPath.row]
            cell.updateModel(model)
            return cell
        }
    }
    // header的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if section == 1 && homeConfig!.fp_tabs.count > 0 {return CGSize(width: screen_width, height: 75)}
        return CGSize(width:0, height: 0)
     }

    // cell 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            if indexPath.row == 0 {
                return CGSize(width: screen_width, height: 150.0)
            }
            return CGSize(width: screen_width, height: 120.0)
        }
        return CGSize(width: screen_width, height: 130.0)
    }
    // update section header view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var sectionIconHeader = UICollectionReusableView()
        if indexPath.section == 1 {
 
            if kind == UICollectionView.elementKindSectionHeader {
                let json_config = readLocalConfiguration()
                let homeConfig = homePageConfigurationList(jsondata: JSON(rawValue: json_config) ?? [])
                
                var sectionIconHeaderView = LLHomeHeader(frame: CGRectZero)
                sectionIconHeaderView  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UICollectionSectionHeader", for: indexPath) as! LLHomeHeader
                sectionIconHeaderView .delegate = self
                sectionIconHeaderView .isUserInteractionEnabled = true
                sectionIconHeaderView.updataMode(pageConfigurationList: homeConfig)
                sectionIconHeaderView.reloadInputViews()
                return sectionIconHeaderView
            }
        }
        return sectionIconHeader
    }
    // touch cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let cell = collectionView.cellForItem(at: indexPath)
            cell!.layer.cornerRadius = 4
            cell?.backgroundColor = UIColor.clear
            
            let model = globalData[indexPath.row]
            let destination = productDetialControl()
            destination.selectModel = model
            self.navigationController?.pushViewController(destination, animated: true)

        }
    }
    
// protocol
    func sectionIconHeaderClick(index: Int) {
        let destination = productListViewControl()
        let model = (homeConfig?.fp_channles.count)! > index ? homeConfig?.fp_channles[index]: skuConfObj(jsondata: "")
        destination.parameter = ["elite_id":model?.model_id,"site":model?.name]
        destination.configModel = model
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    //点击实时热销，更新界面
    func sectionTabBarClick(index: Int){
        let model = homeConfig?.fp_tabs[index]
        requesrParam = ["elite_id":model?.num] as NSDictionary
        print("%@ --- id: %@",model?.num, model?.model_id)
        requestData()
    }
    
    //搜索框，跳转到第二页
    func searchBarClick(index: Int) {
        let destination = SearchViewControl()
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    //点击banner广告位
    func didBannerClick(index: banner) {
        NSLog("%d",index.jump_url)
    }
    
}

