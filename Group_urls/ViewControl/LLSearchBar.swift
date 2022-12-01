//
//  LLSearchBar.swift
//  Group_urls
//
//  Created by Aoli on 2022/11/27.
//

import UIKit

protocol LLSearchBarDelegate: NSObjectProtocol {
    func searchBarClick(index: Int)
}

class LLSearchBar: UICollectionReusableView {
    
    weak var delegate: LLSearchBarDelegate?
    var searchBarImageView: UIImageView?
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    func updataMode(){
        self.backgroundColor = "#FC4A41".uicolor()
        searchBarImageView = UIImageView.init()
        searchBarImageView?.image = UIImage(named: "search_bar_01")
        searchBarImageView?.contentMode = UIView.ContentMode.scaleAspectFit
        searchBarImageView?.isUserInteractionEnabled = true
        searchBarImageView?.tag = 101
        self.addSubview(searchBarImageView!)
        let tap = UITapGestureRecognizer.init(target: self, action:#selector(jumpPage(_:)))
        searchBarImageView!.addGestureRecognizer(tap)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        searchBarImageView?.snp.makeConstraints({ make in
            make.left.equalTo(18)
            make.top.equalTo(4.5)
            make.width.equalTo((UIScreen.main.bounds.size.width-36))
            make.height.equalTo(66)
        })


    }
}
