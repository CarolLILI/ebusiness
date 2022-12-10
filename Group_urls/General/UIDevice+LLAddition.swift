//
//  UIDevice+LLAddition.swift
//  Group_urls
//
//  Created by Aoli on 2022/10/5.
//

import Foundation
import UIKit

extension UIDevice {
    
    static func xp_safeDistanceTop() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0}
            guard let window = windowScene.windows.first else {return 0}
            return window.safeAreaInsets.top
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else {return 0}
            return window.safeAreaInsets.top
        }
        return 0;
    }
    
    static func xp_safeDistanceBottom() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else {return 0}
            guard let window = windowScene.windows.first else {return 0}
            return window.safeAreaInsets.bottom
        } else if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.windows.first else {return 0}
            return window.safeAreaInsets.bottom
        }
        return 0;
    }
    
    static func xp_statusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13, *){
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0}
            guard let statusBarManager = windowScene.statusBarManager else { return 0}
            statusBarHeight = statusBarManager.statusBarFrame.height
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
    
    static func xp_navigationBarHeight() -> CGFloat {
        return 44.0
    }
    
    static func xp_navigationFullHeight() -> CGFloat {
        return UIDevice.xp_statusBarHeight() + UIDevice.xp_navigationBarHeight()
    }
    
    static func xp_tabBarHeight() -> CGFloat {
        return 49.0
    }
    
    static func xp_tabBarFullHeight() -> CGFloat {
        return UIDevice.xp_tabBarHeight() + UIDevice.xp_safeDistanceBottom()
    }
}
