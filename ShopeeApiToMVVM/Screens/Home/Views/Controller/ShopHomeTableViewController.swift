import UIKit

class ShopHomeTableViewController: UITableViewController, NavigationBarConfigurable {
    
    // MARK: - 屬性
    private let viewModel = ShopHomeViewModel()
    private var overlayAdView: OverlayAdView!
    private var overlayAdViewModel: OverlayAdViewModel!
    
    
    private var dynamicIslandHeight: CGFloat {
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
        setupNavigationBar()
        setupTableView()
        viewModel.fetchData()
        
        // 調整 TableView 的內邊距
        tableView.contentInsetAdjustmentBehavior = .never
        
        // 設置滾動指示器的位置
        tableView.scrollIndicatorInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 10,
            right: 0
        )
        
//        ﻿﻿廣告
//        setupOverlayAd()
    }
    
    func setupNavBarCallbacks(for customNavBar: CustomNavBar) {
        customNavBar.onSearchTextChanged = { [weak self] text in
            self?.viewModel.handleSearchTextChanged(text)
        }
        
        customNavBar.onSearchButtonTapped = { [weak self] in
            self?.viewModel.handleSearchButtonTapped()
        }
        
        customNavBar.onCameraButtonTapped = { [weak self] in
            self?.viewModel.handleCameraButtonTapped()
        }
        
        customNavBar.onCartButtonTapped = { [weak self] in
            self?.viewModel.handleCartButtonTapped()
        }
        
        customNavBar.onChatButtonTapped = { [weak self] in
            self?.viewModel.handleChatButtonTapped()
        }
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
        
        // 註冊所有需要的 Cell
        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.reuseIdentifier)
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        tableView.register(FlashSaleCell.self, forCellReuseIdentifier: FlashSaleCell.reuseIdentifier)
        tableView.register(CouponCell.self, forCellReuseIdentifier: CouponCell.reuseIdentifier)
        tableView.register(BrandSaleCell.self, forCellReuseIdentifier: BrandSaleCell.reuseIdentifier)

        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupOverlayAd() {
        // 創建廣告視圖
        overlayAdView = OverlayAdView(frame: view.bounds)
        overlayAdView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(overlayAdView)
        
        // 創建 ViewModel
        let adContent = OverlayAdViewModel.AdContent(
            imageUrl: "your_ad_image_url",
            targetUrl: "your_target_url"
        )
        
        overlayAdViewModel = OverlayAdViewModel(
            adContent: adContent,
            initialDelay: 5.0,  // 5秒後首次顯示
            repeatDelay: 15.0   // 關閉後15秒再次顯示
        )
        
        // 設定廣告點擊事件
        overlayAdViewModel.onAdTapped = { [weak self] in
            // 處理廣告點擊
            print("Ad tapped")
        }
        
        // 配置廣告視圖
        overlayAdView.configure(with: overlayAdViewModel)
    }
    
    deinit {
        overlayAdView.cleanup()
    }
    
//    private func setupOverlayAd() {
//        // 創建廣告視圖
//        overlayAdView = OverlayAdView(frame: view.bounds)
//        overlayAdView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(overlayAdView)
//        
//        // 創建 ViewModel
//        let adContent = OverlayAdViewModel.AdContent(
//            imageUrl: "your_ad_image_url",
//            targetUrl: "your_target_url"
//        )
//        
//        overlayAdViewModel = OverlayAdViewModel(adContent: adContent)
//        
//        // 設定廣告點擊事件
//        overlayAdViewModel.onAdTapped = { [weak self] in
//            // 處理廣告點擊
//            print("Ad tapped")
//        }
//        
//        // 配置廣告視圖
//        overlayAdView.configure(with: overlayAdViewModel)
//    }
    
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
            cell.backgroundColor = .orange
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
            
        case .brandSale:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: BrandSaleCell.reuseIdentifier,
                for: indexPath
            ) as! BrandSaleCell
            cell.configure(with: viewModel.brandSaleViewModel)
            viewModel.brandSaleViewModel.onBrandButtonTapped = {
                print("Brand button tapped")
            }
            viewModel.brandSaleViewModel.onImageTapped = { index in
                print("Brand image \(index) tapped")
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
            return baseBannerHeight * 0.50
            
        case .coupon:
            return baseBannerHeight
            
        case .brandSale:
            return baseBannerHeight * 1.25
        }
    }
}

