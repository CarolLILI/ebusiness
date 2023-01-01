//
//  LLHomePageBannerCell.swift
//  Group_urls
//
//  Created by Aoli on 2022/12/3.
//

import UIKit
import SnapKit
import Kingfisher
import FSPagerView

protocol bannerClickDelegate: NSObjectProtocol {
    func didBannerClick(index: banner)

}

class LLHomePageBannerCell: UICollectionViewCell ,FSPagerViewDelegate,FSPagerViewDataSource,EllipsePageControlDelegate{

    
    weak var delegate: bannerClickDelegate?
    var pagerView: FSPagerView?
    var pageControl: EllipsePageControl?
    var bannerModelList: homePageBannerList?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pagerView?.snp.makeConstraints({ make in
            make.left.equalTo(9)
            make.top.equalTo(0)
            make.width.equalTo(UIScreen.main.bounds.size.width-18)
            make.height.equalTo(self.contentView.frame.size.height)
        })
    }
    
    func initView(){
        pagerView = FSPagerView(frame: self.contentView.frame)
        pagerView!.delegate = self
        pagerView!.dataSource = self
        pagerView!.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.contentView.addSubview(pagerView!)
        
        pagerView!.layer.cornerRadius = 10
        pagerView!.layer.masksToBounds = true
        pagerView?.automaticSlidingInterval = 3.0
        pagerView?.isInfinite = true
        pagerView?.decelerationDistance = 2
        
        pageControl = EllipsePageControl(frame: CGRectMake(0, self.contentView.frame.height-30,UIScreen.main.bounds.size.width, 30))
        pageControl?.numberOfPages = 0
        pageControl?.delegate = self
        pageControl?.otherColor = UIColor.white
        pageControl?.currentColor = UIColor.white
        pageControl?.currentPage = 0
        pageControl?.controlSpacing = 6
        pageControl?.controlSize = 5
        self.contentView.addSubview(pageControl!)
        
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        if bannerModelList!.list.count > 0 {
            pageControl?.numberOfPages  = bannerModelList!.list.count
            return bannerModelList!.list.count
        }
        else {
            pageControl?.numberOfPages = 0
            return 0
        }
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
//        cell.imageView?.image = UIImage(named: "banner")
        let bannerModel = bannerModelList?.list[index]
        let url = URL(string: BASE_REL + bannerModel!.image)
//        cell.imageView?.kf.setImage(with: url)
        cell.imageView?.kf.setImage(with: url, placeholder: UIImage(named: "defalut_bgImg"))
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int){
        let select = bannerModelList?.list[index]
        self.delegate?.didBannerClick(index: select!)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int){
//        NSLog("Dragging %d", pagerView.currentIndex)
        pageControl?.currentPage = pagerView.currentIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView){
        pageControl?.currentPage = pagerView.currentIndex

//        NSLog("animation %d", pagerView.currentIndex)
    }
    func ellipsePageControlClick(_ pageControl: EllipsePageControl!, index clickIndex: Int) {
//        NSLog("ellipsePage %d", clickIndex)
    }
}
