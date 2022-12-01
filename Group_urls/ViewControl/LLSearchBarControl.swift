//
//  LLSearchBarControl.swift
//  Group_urls
//
//  Created by Aoli on 2022/11/27.
//

import UIKit

class LLSearchBarControl: UIView,UISearchBarDelegate {
    var searchBar: UISearchBar?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar?.snp.makeConstraints({ make in
            make.left.equalTo(18)
            make.top.equalTo(100)
            make.width.equalTo((UIScreen.main.bounds.size.width-36))
            make.height.equalTo(66)
        })
    }
    
    func initContentView(){
        searchBar = UISearchBar()
        searchBar!.placeholder = "请输入关键字"
//        searchBar!.text = "GO"
        searchBar!.barStyle = UIBarStyle.blackOpaque
//        searchBar!.prompt = "Yeah!"
//        searchBar!.showsBookmarkButton = true
//        searchBar!.showsCancelButton = true
        searchBar!.setShowsCancelButton(true, animated: true)
        searchBar!.showsSearchResultsButton = true
        searchBar!.tintColor = UIColor.red
        searchBar!.barTintColor = UIColor.white
        searchBar!.scopeButtonTitles = ["1","2","3","4"]
        searchBar!.showsScopeBar = true
        searchBar!.sizeToFit()
        searchBar!.delegate = self
        self.addSubview(searchBar!)
    }
    
    //代理回调函数
    //点击附件视图代理方法的回调
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print(selectedScope)
    }
    //当输入文字变化时调用的方法
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
    }
    //点击图书按钮触发的方法
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("点击了图书")
    }
    //点击搜索结果按钮触发的方法
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
            
    }
    //将要进入编辑状态触发的方法
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    //将要结束编辑时触发的方法
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
            return true
    }
    //检测用户的输入文字
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(text)
        return true
    }
    //点击取消按钮时触发的方法
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            
    }
    //点击搜索按钮触发的方法
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
    }
    //已经进入编辑状态时调用的方法
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            
    }
    //将要结束编辑时触发的方法
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar!.resignFirstResponder()
    }
}
