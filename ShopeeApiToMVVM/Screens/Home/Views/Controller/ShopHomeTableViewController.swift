//
//  ViewController.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/7.
//

import UIKit

class ShopHomeTableViewController: UITableViewController {
    
    
    // MARK: - 屬性
    private let viewModel = ShopHomeViewModel()
    private let customNavBar = CustomNavBar()
    
    private var dynamicIslandHeight: CGFloat {
        // 獲取視窗的安全區域頂部高度
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.top ?? 0
    }
     
     // MARK: - 初始化
     override init(style: UITableView.Style = .plain) {
         super.init(style: style)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 先設置 searchBar，因為它會影響 tableView 的位置
        setupCustomNavBar()
        setupTableView()
        bindViewModel()
        viewModel.fetchData()
        
        customNavBar.backgroundColor = .clear

        // 調整 TableView 的內邊距
        tableView.contentInsetAdjustmentBehavior = .never // 關閉自動調整

        let topPadding = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0

        // 調整 TableView 的內邊距，使其對齊動態島頂部
        tableView.contentInset = UIEdgeInsets(
            top: topPadding - dynamicIslandHeight,  // 負值使內容向上移動到動態島頂部
            left: 0,
            bottom: 10,
            right: 0
        )
        
        // 設置滾動指示器的位置
        tableView.scrollIndicatorInsets = UIEdgeInsets(
            top: 50, // navbar 的高度
            left: 0,
            bottom: 10,
            right: 0
        )
    }
    
    private func setupCustomNavBar() {
        
        view.addSubview(customNavBar)

        NSLayoutConstraint.activate([
            // Custom Navbar
            customNavBar.topAnchor.constraint(equalTo: view.topAnchor, constant: dynamicIslandHeight),
            customNavBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        setupNavBarCallbacks()
    }
    
    
    private func setupNavBarCallbacks() {
        customNavBar.onSearchTextChanged = { [weak self] text in
            print("Search text changed: \(text)")
        }
        
        customNavBar.onSearchButtonTapped = { [weak self] in
            print("Search button tapped")
        }
        
        customNavBar.onCameraButtonTapped = { [weak self] in
            print("Camera button tapped")
        }
        
        customNavBar.onCartButtonTapped = { [weak self] in
            print("Cart button tapped")
        }
        
        customNavBar.onChatButtonTapped = { [weak self] in
            print("Chat button tapped")
        }
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showError(message: error)
                self?.refreshControl?.endRefreshing()
            }
        }
    }

     
     // MARK: - 更新資料方法
     @objc private func refreshData() {
         viewModel.fetchData()
     }
    
        private func showError(message: String) {
            let alert = UIAlertController(
                title: "錯誤",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "確定", style: .default))
            present(alert, animated: true)
        }
    
    private func setupTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        
        // 註冊所有需要的 Cell
        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.reuseIdentifier)
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        tableView.register(FlashSaleCell.self, forCellReuseIdentifier: FlashSaleCell.reuseIdentifier)
        tableView.register(CouponCell.self, forCellReuseIdentifier: CouponCell.reuseIdentifier)

        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - UITableView 資料來源方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = ShopHomeViewModel.Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch section {
        case .banner:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: BannerCell.reuseIdentifier,
                for: indexPath
            ) as! BannerCell
            cell.configure(with: viewModel.bannerItems)
            return cell
            

            
        case .category:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryTableViewCell.reuseIdentifier,
                for: indexPath
            ) as! CategoryTableViewCell
            cell.configure(with: viewModel.categoryViewModel)
            cell.backgroundColor = .systemOrange
            return cell
            
        case .flashSale:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FlashSaleCell.reuseIdentifier,
                for: indexPath
            ) as! FlashSaleCell
            cell.configure(with: viewModel.flashSaleViewModel)
            
            cell.onFirstButtonTapped = {
                print("First button tapped")
            }
            cell.onSecondButtonTapped = {
                print("Second button tapped")
            }
            cell.onThirdButtonTapped = {
                print("Third button tapped")
            }
            return cell
            
        case .coupon:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CouponCell.reuseIdentifier,
                for: indexPath
            ) as! CouponCell
            cell.configure(with: viewModel.couponViewModel)
            cell.onCouponButtonTapped = {
                print("Coupon button tapped")
            }
            return cell
        
        }
    }
 

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = ShopHomeViewModel.Section(rawValue: indexPath.section) else {
            return 0
        }
        
        // 基準寬度和計算比例
        let screenWidth = tableView.bounds.width
        let bannerRatio: CGFloat = 3.4 / 6.4
        let baseBannerHeight = screenWidth * bannerRatio
        
        switch section {
        case .banner:
            return baseBannerHeight
            
        case .category:
            // Category Cell 計算參數
            let spacing: CGFloat = 5
            let sideMargin: CGFloat = 15
            let labelHeight: CGFloat = 15
            
            // 計算單個 item 的尺寸
            let availableWidth = screenWidth - sideMargin
            let itemWidth = (availableWidth - spacing * 4) / 5
            let itemHeight = itemWidth + labelHeight
            
            // 計算總高度（兩行）
            let rowSpacing: CGFloat = 5
            let totalHeight = (itemHeight * 2) + rowSpacing + spacing
            return totalHeight
            
        case .flashSale:
            return baseBannerHeight * 0.65
            
        case .coupon:
            return baseBannerHeight * 0.8
        }
        

    }
 


}
