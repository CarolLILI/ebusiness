//
//  BaseViewController.swift
//  Group_urls
//
//  Created by Aoli on 2022/10/9.
//

import Foundation
import UIKit


@available(iOS 13.0, *)
class BaseViewController: UIViewController {
    
    var bgImg: UIImageView?
    var screen_width:CGFloat!
    var screen_height:CGFloat!
    var backIcon: UIImageView?
    var baseTitle: UILabel?
    var searchBarHeaderView: LLSearchBarControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航栏背景为透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isHidden = true
        
        
        bgImg = UIImageView.init()
        bgImg!.backgroundColor = UIColor.clear
        bgImg?.isHidden = true
        self.view.addSubview(bgImg!)
        let size = CGSize(width: view.bounds.width, height: UIDevice.xp_navigationFullHeight())
        
        bgImg!.snp.makeConstraints { make in
            make.top.equalTo(UIDevice.xp_navigationBarHeight())
            make.width.equalTo(size.width)
            make.height.equalTo(size.height)
        }
        
        addNavBar(.cyan)
        addSearchBar()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
    
    //添加自定义导航栏背景
    func addNavBar(_ color: UIColor) {
        

        
        backIcon = UIImageView.init(frame: CGRectMake(12, 15, 7,14))
        backIcon!.image = UIImage(named: "backIcn")
        backIcon!.contentMode = .scaleAspectFit
        bgImg!.addSubview(backIcon!)
        bgImg?.isUserInteractionEnabled = true
        backIcon?.isUserInteractionEnabled = true
        
        let backBgView = UIView.init()
        backBgView.backgroundColor = UIColor.clear
        backBgView.frame = CGRectMake(0, 0, 32, 33)
        backBgView.isUserInteractionEnabled = true
        bgImg!.addSubview(backBgView)
        
        let tap = UITapGestureRecognizer.init(target: self, action:#selector(backPreviousPages(_:)))
        backBgView.addGestureRecognizer(tap)
        
        baseTitle = UILabel.init(frame: CGRectZero)
        baseTitle?.textAlignment = .center
        baseTitle?.textColor = "#222222".uicolor()
        baseTitle?.font = UIFont.systemFont(ofSize: 14)
        bgImg?.addSubview(baseTitle!)
        
        baseTitle?.snp.makeConstraints({ make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(UIDevice.xp_navigationFullHeight()-UIDevice.xp_navigationBarHeight())
        })
        
    }
    
    func addSearchBar(){
        searchBarHeaderView = LLSearchBarControl()
        searchBarHeaderView!.isUserInteractionEnabled = true
        searchBarHeaderView?.isHidden = true
        searchBarHeaderView?.backgroundColor = UIColor.clear
        bgImg!.addSubview(searchBarHeaderView!)
        
        searchBarHeaderView!.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(32)
            make.right.equalTo(0)
            make.height.equalTo(UIDevice.xp_navigationFullHeight()-UIDevice.xp_navigationBarHeight())
        }
    }
    
    @objc func backPreviousPages(
        _ sender: UITapGestureRecognizer
    ){
        self.navigationController?.popViewController(animated: true)
    }
    
}
