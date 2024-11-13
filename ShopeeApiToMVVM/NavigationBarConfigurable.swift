//
//  NavigationBarConfigurable.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/13.
//

import UIKit

protocol NavigationBarConfigurable {
    func setupNavigationBar()
    func configureNavigationBarAppearance()
    func setupNavBarCallbacks(for customNavBar: CustomNavBar)
}

extension NavigationBarConfigurable where Self: UIViewController {
    func configureNavigationBarAppearance() {
        // 移除導航欄的預設外觀
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .clear
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    func setupNavigationBar() {
        print("\(type(of: self)) - setupNavigationBar started")
        
        let customNavBar = CustomNavBar(frame: .zero)
        setupNavBarCallbacks(for: customNavBar)
        
        configureNavigationBarAppearance()
        navigationItem.titleView = customNavBar
    }
}
