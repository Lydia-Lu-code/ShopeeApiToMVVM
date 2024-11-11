import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers()
        setupTabBarAppearance()
    }
    
    private func setupTabBarAppearance() {
        // 設置 TabBar 的外觀
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func setViewControllers() {
        // 蝦拚首頁
        let homeVC = ShopHomeTableViewController()
        let homeNav = createNavigationController(
            for: homeVC,
            title: "蝦拚",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"),
            tag: 0
        )
        
        // 商城
        let mallVC = MallViewController()
        let mallNav = createNavigationController(
            for: mallVC,
            title: "商城",
            image: UIImage(systemName: "bag"),
            selectedImage: UIImage(systemName: "bag.fill"),
            tag: 1
        )
        
        // 直播
        let liveVC = LiveViewController()
        let liveNav = createNavigationController(
            for: liveVC,
            title: "直播",
            image: UIImage(systemName: "video"),
            selectedImage: UIImage(systemName: "video.fill"),
            tag: 2
        )
        
        // 通知
        let notificationVC = NotificationViewController()
        let notificationNav = createNavigationController(
            for: notificationVC,
            title: "通知",
            image: UIImage(systemName: "bell"),
            selectedImage: UIImage(systemName: "bell.fill"),
            tag: 3
        )
        
        // 我的
        let profileTableViewController = ProfileTableViewController()
        let profileNav = createNavigationController(
            for: profileTableViewController,
            title: "我的",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"),
            tag: 4
        )
        
        // 設置標籤欄控制器的所有子視圖控制器
        self.viewControllers = [homeNav, mallNav, liveNav, notificationNav, profileNav]
    }
    
    // 更新 createNavigationController 方法以支援設置圖示
    private func createNavigationController(
        for rootViewController: UIViewController,
        title: String,
        image: UIImage?,
        selectedImage: UIImage?,
        tag: Int
    ) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem = UITabBarItem(
            title: title,
            image: image,
            selectedImage: selectedImage
        )
        nav.tabBarItem.tag = tag
        rootViewController.title = title
        return nav
    }
}
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setViewControllers()
//        setupNavigationBarAppearance()
//    }
//
//    private func setViewControllers() {
//        // HomeVC
//        let homeVC = HomeTableViewController()
//        let homeNav = createNavigationController(for: homeVC, title: "Home", tag: 0)
//        
//        // ShortsVC
//        let shortsVC = ShortsTableViewController()
//        let shortsNav = UINavigationController(rootViewController: shortsVC)
//        shortsNav.tabBarItem = UITabBarItem(title: "Shorts", image: nil, tag: 1)
//        shortsNav.navigationBar.isHidden = true // 隱藏 ShortsTableViewController 的導航欄
//        
//        // PhotoViewController
//        let photoVC = PhotoViewController()
//        let addNav = createNavigationController(for: photoVC, title: "Add", tag: 2)
//        
//        // SubscribeVC
//        let subscribeVC = SubscribeViewController()
//        let subscribeNav = createNavigationController(for: subscribeVC, title: "Subscribe", tag: 3)
//        
//        // ContentVC
//        let contentTableViewController = ContentTableViewController()
//        let contentNav = createNavigationController(for: contentTableViewController, title: "Content", tag: 4)
//        
//        // 設置標籤欄控制器的所有子視圖控制器
//        self.viewControllers = [homeNav, shortsNav, addNav, subscribeNav, contentNav]
//    }
//    
//    private func createNavigationController(for rootViewController: UIViewController,
//                                            title: String,
//                                            tag: Int) -> UINavigationController {
//        let navController = UINavigationController(rootViewController: rootViewController)
//        navController.tabBarItem = UITabBarItem(title: title, image: nil, tag: tag)
//        return navController
//    }
//    
//    private func setupNavigationBarAppearance() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        updateNavigationBarColors(appearance: appearance)
//        
//        viewControllers?.forEach { viewController in
//            if let navController = viewController as? UINavigationController,
//               !(navController.viewControllers.first is ShortsTableViewController) {
//                navController.navigationBar.standardAppearance = appearance
//                navController.navigationBar.scrollEdgeAppearance = appearance
//                navController.navigationBar.compactAppearance = appearance
//            }
//        }
//    }
//    
//    private func updateNavigationBarColors(appearance: UINavigationBarAppearance) {
//        let backgroundColor = UIColor { traitCollection in
//            switch traitCollection.userInterfaceStyle {
//            case .dark:
//                return .black
//            default:
//                return .white
//            }
//        }
//        
//        appearance.backgroundColor = backgroundColor
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
//        
//        viewControllers?.forEach { viewController in
//            if let navController = viewController as? UINavigationController,
//               !(navController.viewControllers.first is ShortsTableViewController) {
//                navController.navigationBar.tintColor = .label
//            }
//        }
//    }
//    
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            updateNavigationBarColors(appearance: appearance)
//            setupNavigationBarAppearance()
//        }
//    }
//}
