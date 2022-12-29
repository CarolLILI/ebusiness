//
//  LLSearchBar.swift
//  Group_urls
//
//  Created by Aoli on 2022/11/27.
//

import UIKit

protocol LLSearchBarDelegate: NSObjectProtocol {
    func searchBarClick(index: Int)
    func shareBtnClick()
}

class LLSearchBar: UICollectionReusableView {
    
    weak var delegate: LLSearchBarDelegate?
    var searchBarImageView: UIImageView?
    var shareImg: UIImageView?
    override init(frame: CGRect) {
        super.init(frame: frame)
//        //swift 背景渐变
//        let layer1 = CAGradientLayer()
//        layer1.colors = [UIColor(red: 1, green: 0.282, blue: 0.29, alpha: 1).cgColor,
//                         UIColor(red: 1, green: 0.91, blue: 0.873, alpha: 0.49).cgColor,
//                         UIColor(red: 1, green: 0.938, blue: 0.873, alpha: 0).cgColor,
//                         UIColor(red: 1, green: 0.939, blue: 0.874, alpha: 1).cgColor]
//        layer1.locations = [0,0.89,1,1]
//        layer1.startPoint = CGPoint(x: 0.5, y: 0)
//        layer1.endPoint = CGPoint(x: 0.5, y: 1)
//        layer1.frame = CGRectMake(0, 0, UIScreen.main.bounds.size.width, 80)
//        layer1.position = self.center
//        self.layer.addSublayer(layer1)
        updataMode()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func jumpPage(
       _ sender: UITapGestureRecognizer
    ){
        let tapLocation = sender.view
        self.delegate?.searchBarClick(index:tapLocation!.tag)
    }
    
    
    @objc func shareAction(
        _ sender: UITapGestureRecognizer
    ){

        self.delegate?.shareBtnClick()
    }
    
    func updataMode(){
        searchBarImageView = UIImageView.init()
        searchBarImageView?.image = UIImage(named: "search_bar_01")
        searchBarImageView?.contentMode = UIView.ContentMode.scaleAspectFit
        searchBarImageView?.isUserInteractionEnabled = true
        searchBarImageView?.tag = 101
        self.addSubview(searchBarImageView!)
        let tap = UITapGestureRecognizer.init(target: self, action:#selector(jumpPage(_:)))
        searchBarImageView!.addGestureRecognizer(tap)
        
        shareImg = UIImageView.init()
        shareImg!.image = UIImage(named: "share_icon")
        shareImg!.isUserInteractionEnabled = true
        shareImg!.contentMode = .scaleAspectFit
        self.addSubview(shareImg!)

        let tap2 = UITapGestureRecognizer.init(target: self, action:#selector(shareAction(_:)))
        shareImg!.addGestureRecognizer(tap2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        searchBarImageView?.snp.makeConstraints({ make in
            make.left.equalTo(9)
            make.top.equalTo(4.5)
            make.width.equalTo((UIScreen.main.bounds.size.width-52))
            make.height.equalTo(66)
        })

        shareImg?.snp.makeConstraints { make in
            make.right.equalTo(-11)
            make.centerY.equalTo(searchBarImageView!.snp.centerY)
            make.width.height.equalTo(20)
        }

    }
}
