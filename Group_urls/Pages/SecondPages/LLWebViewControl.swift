//
//  LLWebViewControl.swift
//  Group_urls
//
//  Created by Aoli on 2023/1/2.
//

import Foundation
import UIKit
import WebKit

@available(iOS 13.0, *)
class LLWebViewControl:BaseViewController,WKNavigationDelegate{
    
    var jump_url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgImg?.isHidden = false
        
       
        let webView: WKWebView = WKWebView(frame: CGRectMake(0, UIDevice.xp_navigationFullHeight(), UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height - UIDevice.xp_navigationFullHeight()))
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        
        let request_url = NSURL(string: jump_url!)
        
        webView.load(NSURLRequest(url: request_url! as URL) as URLRequest)

    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.view.makeToastActivity(.center)
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         
        self.view.hideToastActivity()
        
        self.baseTitle?.text = webView.title
    }
    
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        self.view.makeToast("error: \(error)")
    }
    
}
