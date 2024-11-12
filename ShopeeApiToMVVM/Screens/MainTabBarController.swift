import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers()
        setupTabBarAppearance()
    }
    
    private func setupTabBarAppearance() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func setViewControllers() {
        let homeVC = ShopHomeTableViewController()
        let homeNav = createNavigationController(
            for: homeVC,
            title: "﻿蝦拚",  // 加入標題
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"),
            tag: 0
        )
        
        let mallVC = MallViewController()
        let mallNav = createNavigationController(
            for: mallVC,
            title: "商城",  // 加入標題
            image: UIImage(systemName: "bag"),
            selectedImage: UIImage(systemName: "bag.fill"),
            tag: 1
        )
        
        let liveVC = LiveViewController()
        let liveNav = createNavigationController(
            for: liveVC,
            title: "直播",  // 加入標題
            image: UIImage(systemName: "video"),
            selectedImage: UIImage(systemName: "video.fill"),
            tag: 2
        )
        
        let notificationVC = NotificationViewController()
        let notificationNav = createNavigationController(
            for: notificationVC,
            title: "通知",  // 加入標題
            image: UIImage(systemName: "bell"),
            selectedImage: UIImage(systemName: "bell.fill"),
            tag: 3
        )
        
        let profileTableViewController = ProfileTableViewController()
        let profileNav = createNavigationController(
            for: profileTableViewController,
            title: "我的",  // 加入標題
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"),
            tag: 4
        )
        
        self.viewControllers = [homeNav, mallNav, liveNav, notificationNav, profileNav]
    }

    private func createNavigationController(
        for rootViewController: UIViewController,
        title: String,  // 新增 title 參數
        image: UIImage?,
        selectedImage: UIImage?,
        tag: Int
    ) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem = UITabBarItem(
            title: title,  // 使用傳入的標題
            image: image,
            selectedImage: selectedImage
        )
        nav.tabBarItem.tag = tag
        return nav
    }

}

