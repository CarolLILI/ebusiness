//
//  AppDelegate.swift
//  Group_urls
//
//  Created by Aoli on 2022/8/11.
//

import UIKit
import ESTabBarController_swift


@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let tabBarControl = ESTabBarController.init()
        let control_1 = ViewController.init()
        let control_2 = SecondViewControl.init()
        let control_3 = ThirdViewControl.init()
        let control_4 = FourthViewControl.init()
        
        control_1.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView.init(), title: "首页", image: UIImage(named: "house"), selectedImage: UIImage(named: "house.fill"), tag: 1)
        control_2.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView.init(), title: "佣金", image: UIImage(named: "dollarsign.circle"), selectedImage: UIImage(named: "dollarsign.circle.fill"), tag: 2)
        control_3.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView.init(), title: "收藏", image: UIImage(named: "star"), selectedImage: UIImage(named: "star.fill"), tag: 3)
        control_4.tabBarItem = ESTabBarItem.init(ESTabBarItemContentView.init(), title: "我", image: UIImage(named: "person"), selectedImage: UIImage(named: "person.fill"), tag: 4)
        
        let navigation_1 = UINavigationController.init(rootViewController: control_1)
        let navigation_2 = UINavigationController.init(rootViewController: control_2)
        let navigation_3 = UINavigationController.init(rootViewController: control_3)
        let navigation_4 = UINavigationController.init(rootViewController: control_4)
        
        navigation_1.title = "Home"
        navigation_2.title = "Cash"
        navigation_3.title = "Street"
        navigation_4.title = "Me"
        
        tabBarControl.viewControllers = [navigation_1, navigation_2, navigation_3, navigation_4]
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = tabBarControl
        self.window?.makeKeyAndVisible()
        return true
    }
    // MARK: UISceneSession Lifecycle
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
}

