//
//  LLSearchBarControl.swift
//  Group_urls
//
//  Created by Aoli on 2022/11/27.
//

import UIKit

typealias funcBlock = (String) -> ()

@available(iOS 13.0, *)
class LLSearchBarControl: UIView,UITextFieldDelegate{
    var searchBar: UITextField?
    var bgImg: UIImageView?
    var searchIcon: UILabel?
    var searchLeftIcon: UIImageView?
    var clickSearchBtn: funcBlock!
    var keyWord: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        bgImg!.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(self.frame.size.width-12)
            make.height.equalTo(self.frame.size.height)
        }
        
        searchBar?.snp.makeConstraints({ make in
            make.left.equalTo(32)
            make.top.equalTo(1)
            make.width.equalTo(self.frame.size.width - 80)
            make.height.equalTo(self.frame.size.height-2)
        })
        
        searchIcon!.snp.makeConstraints { make in
            make.right.equalTo(bgImg!.snp.right).offset(0)
            make.top.equalTo(bgImg!.snp.top).offset(12)
            make.bottom.equalTo(bgImg!.snp.bottom).offset(-12)
            make.width.equalTo(61)
        }
        
        searchLeftIcon?.snp.makeConstraints({ make in
            make.left.equalTo(12)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(12.5)
        })
    }
    
    func initContentView(){
 
        bgImg = UIImageView.init()
        bgImg!.backgroundColor = UIColor.clear
        bgImg!.image = UIImage(named: "search_bg")
        bgImg!.contentMode = .scaleAspectFit
        bgImg!.isUserInteractionEnabled = true
        self.addSubview(bgImg!)

        searchBar = UITextField.init()
        searchBar?.textColor = "#222222".uicolor()
        searchBar?.placeholder = "请输入关键字"
        searchBar?.textAlignment = .left
        searchBar?.borderStyle = .none
        searchBar?.delegate = self
        searchBar?.returnKeyType = UIReturnKeyType.done
        searchBar?.keyboardType = UIKeyboardType.default
        searchBar?.clearButtonMode = .whileEditing
        searchBar?.keyboardAppearance = UIKeyboardAppearance.light
        searchBar?.resignFirstResponder()
        searchBar?.isUserInteractionEnabled = true
        bgImg!.addSubview(searchBar!)
        
        searchIcon = UILabel.init()
        searchIcon!.backgroundColor = "#FC473F".uicolor()
        searchIcon!.text = "搜索"
        searchIcon!.textColor = UIColor.white
        searchIcon!.font = UIFont.systemFont(ofSize: 12)
        searchIcon!.textAlignment = .center
        searchIcon!.layer.cornerRadius = 14
        searchIcon!.layer.borderWidth = 0
        searchIcon!.layer.masksToBounds = true
        searchIcon!.isUserInteractionEnabled = true
        bgImg!.addSubview(searchIcon!)
        let tap = UITapGestureRecognizer.init(target: self, action:#selector(searchRequest(_:)))
        searchIcon!.addGestureRecognizer(tap)
        
        
        searchLeftIcon = UIImageView.init()
        searchLeftIcon?.backgroundColor = UIColor.clear
        searchLeftIcon?.image = UIImage(named: "search_left_icon")
        searchLeftIcon?.contentMode = .scaleAspectFit
        searchLeftIcon?.isUserInteractionEnabled = true
        bgImg!.addSubview(searchLeftIcon!)
        


    }
    
    @objc func searchRequest(
        _ sender: UITapGestureRecognizer
    ){
        if (keyWord != nil) && keyWord!.count > 0 {
            self.endEditing(false)
            clickSearchBtn!(keyWord!)
            
        }
        
        
    }
    
    
    //代理回调函数
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            print("将要开始编辑")
            return true
    }
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("已经开始编辑")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("将要结束编辑")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("已经结束编辑")
        
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let fullStr = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        keyWord = fullStr
        keyWord = keyWord?.replacingOccurrences(of: " ", with: "")
        
        print("文本输入内容将要发生变化（每次输入都会调用）\(keyWord)")
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("将要清除输入内容，返回值是是否要清除掉内容")
        keyWord = ""
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("将要按下Return按钮，返回值是是否结束输入（是否失去焦点）")
        if keyWord!.count > 0 {
            clickSearchBtn(keyWord!)
        }
        textField.resignFirstResponder()
        return true
    }
}
