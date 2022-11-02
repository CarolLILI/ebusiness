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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航栏背景为透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isHidden = true
        addNavBar(.cyan)
        
        bgImg = UIImageView.init()
        bgImg!.backgroundColor = UIColor.clear
        self.view.addSubview(bgImg!)
        
        bgImg!.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
    
    //添加自定义导航栏背景
    func addNavBar(_ color: UIColor) {
        
        let size = CGSize(width: view.bounds.width, height: UIDevice.xp_navigationFullHeight())
        let navImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.addSubview(navImageView)
    }
}
