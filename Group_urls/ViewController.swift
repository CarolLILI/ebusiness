//
//  ViewController.swift
//  Group_urls
//
//  Created by Aoli on 2022/8/11.
//

import UIKit
//swift 第三方库：（https://wenku.baidu.com/view/693d222eeb7101f69e3143323968011ca300f7f3.html）
//网络请求库：Alamofire （https://www.cnblogs.com/lfri/p/14067146.html）
//sdwebimage 库：Kingfisher（https://github.com/onevcat/Kingfisher）
//请求数据解析库：https://github.com/SwiftyJSON/SwiftyJSON (https://www.jianshu.com/p/288b3d15cfde)
//SnapKit 自动布局：https://github.com/SnapKit/SnapKit
//DGElasticPullToRefresh
import Alamofire
import SnapKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var screen_width:CGFloat!
    var screen_height:CGFloat!
    var collectionView: UICollectionView?
    let headerHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        screen_width = UIScreen.main.bounds.size.width
        screen_height = UIScreen.main.bounds.size.height
        setCollectionView()
        
    }
    
    func setCollectionView(){
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: screen_width/2, height: screen_height/3)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout:layout)
        collectionView?.register(LLCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.backgroundColor = UIColor.white
        self.view.addSubview(collectionView!)
        
        collectionView?.register(LLHomeHeader.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UICollectionSectionHeader")
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // update cell 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LLCollectionViewCell
        cell.updateModel()
        return cell
    }
    
    // header的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
         return CGSize(width: screen_width, height: 200)
     }
    // cell 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screen_width, height: 100.0)
    }
    // update header view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var llHearder = LLHomeHeader()
        if kind == UICollectionView.elementKindSectionHeader {
            llHearder = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UICollectionSectionHeader", for: indexPath) as! LLHomeHeader
        }
        llHearder.updataMode()
        return llHearder
    }
    // touch cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell!.layer.cornerRadius = 4
        cell?.backgroundColor = UIColor.yellow
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell!.layer.cornerRadius = 4
        cell?.backgroundColor = UIColor.white
    }
    
    

}

