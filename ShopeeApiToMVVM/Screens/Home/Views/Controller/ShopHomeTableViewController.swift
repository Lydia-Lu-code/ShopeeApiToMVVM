import UIKit

class ShopHomeTableViewController: UITableViewController {
    
    // MARK: - 屬性
    private let viewModel = ShopHomeViewModel()
    
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
        bindViewModel()
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
    }
    
    

    private func setupNavigationBar() {
        print("ShopHomeTableViewController - setupNavigationBar started")

        let customNavBar = CustomNavBar(frame: .zero)
        setupNavBarCallbacks(for: customNavBar)
        
        print("NavigationBar height before:", navigationController?.navigationBar.frame.height ?? 0)
            
        // 移除導航欄的預設外觀
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // 設定自訂視圖為導航欄的標題視圖
        navigationItem.titleView = customNavBar
        
        // 調整導航欄的外觀和高度
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .clear
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            
            print("NavigationBar appearance set")

        }
        
        print("NavigationBar height after:", navigationController?.navigationBar.frame.height ?? 0)
        print("CustomNavBar frame:", customNavBar.frame)

    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        // 確保CustomNavBar位置正確
//        customNavBar.frame.origin.y = 0
//    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        print("ShopHomeTableViewController - viewDidLayoutSubviews")
////        print("NavigationBar height in layoutSubviews:", navigationController?.navigationBar.frame.height ?? 0)
//
//    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ShopHomeTableViewController - viewDidAppear")
        print("Final NavigationBar height:", navigationController?.navigationBar.frame.height ?? 0)
        print("Final CustomNavBar frame:", navigationItem.titleView?.frame ?? .zero)
    }
    
    func setupNavBarCallbacks(for customNavBar: CustomNavBar) {
        customNavBar.onSearchTextChanged = { [weak self] text in
            self?.viewModel.handleSearchTextChanged(text)
            print("Search text changed: \(text)")
        }
    
//    private func setupNavBarCallbacks(for customNavBar: CustomNavBar) {
//        customNavBar.onSearchTextChanged = { [weak self] text in
//            print("Search text changed: \(text)")
//        }
        
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

//import UIKit
//
//class ShopHomeTableViewController: UITableViewController {
//    
//    
//    // MARK: - 屬性
//    private let viewModel = ShopHomeViewModel()
//    private let customNavBar = CustomNavBar()
//    
//    private var dynamicIslandHeight: CGFloat {
//        // 獲取視窗的安全區域頂部高度
//        let window = UIApplication.shared.windows.first
//        return window?.safeAreaInsets.top ?? 0
//    }
//     
//     // MARK: - 初始化
//     override init(style: UITableView.Style = .plain) {
//         super.init(style: style)
//     }
//     
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        // 先設置 searchBar，因為它會影響 tableView 的位置
//        setupCustomNavBar()
//        setupTableView()
//        bindViewModel()
//        viewModel.fetchData()
//        
//        customNavBar.backgroundColor = .clear
//
//        // 調整 TableView 的內邊距
//        tableView.contentInsetAdjustmentBehavior = .never // 關閉自動調整
//
//        let topPadding = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
//
//        // 調整 TableView 的內邊距，使其對齊動態島頂部
//        tableView.contentInset = UIEdgeInsets(
//            top: topPadding - dynamicIslandHeight,  // 負值使內容向上移動到動態島頂部
//            left: 0,
//            bottom: 10,
//            right: 0
//        )
//        
//        // 設置滾動指示器的位置
//        tableView.scrollIndicatorInsets = UIEdgeInsets(
//            top: 50, // navbar 的高度
//            left: 0,
//            bottom: 10,
//            right: 0
//        )
//    }
//    
//    private func setupCustomNavBar() {
//        
//        view.addSubview(customNavBar)
//
//        NSLayoutConstraint.activate([
//            // Custom Navbar
//            customNavBar.topAnchor.constraint(equalTo: view.topAnchor, constant: dynamicIslandHeight),
//            customNavBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            customNavBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            customNavBar.heightAnchor.constraint(equalToConstant: 50),
//            
//        ])
//        
//        setupNavBarCallbacks()
//    }
//    
//    
//    private func setupNavBarCallbacks() {
//        customNavBar.onSearchTextChanged = { [weak self] text in
//            print("Search text changed: \(text)")
//        }
//        
//        customNavBar.onSearchButtonTapped = { [weak self] in
//            print("Search button tapped")
//        }
//        
//        customNavBar.onCameraButtonTapped = { [weak self] in
//            print("Camera button tapped")
//        }
//        
//        customNavBar.onCartButtonTapped = { [weak self] in
//            print("Cart button tapped")
//        }
//        
//        customNavBar.onChatButtonTapped = { [weak self] in
//            print("Chat button tapped")
//        }
//    }
//    
//    private func bindViewModel() {
//        viewModel.onDataUpdate = { [weak self] in
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//                self?.refreshControl?.endRefreshing()
//            }
//        }
//        
//        viewModel.onError = { [weak self] error in
//            DispatchQueue.main.async {
//                self?.showError(message: error)
//                self?.refreshControl?.endRefreshing()
//            }
//        }
//    }
//
//     
//     // MARK: - 更新資料方法
//     @objc private func refreshData() {
//         viewModel.fetchData()
//     }
//    
//        private func showError(message: String) {
//            let alert = UIAlertController(
//                title: "錯誤",
//                message: message,
//                preferredStyle: .alert
//            )
//            alert.addAction(UIAlertAction(title: "確定", style: .default))
//            present(alert, animated: true)
//        }
//    
//    private func setupTableView() {
//        tableView.backgroundColor = .systemBackground
//        tableView.separatorStyle = .none
//        tableView.contentInsetAdjustmentBehavior = .never
//        
//        // 註冊所有需要的 Cell
//        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.reuseIdentifier)
//        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
//        tableView.register(FlashSaleCell.self, forCellReuseIdentifier: FlashSaleCell.reuseIdentifier)
//        tableView.register(CouponCell.self, forCellReuseIdentifier: CouponCell.reuseIdentifier)
//
//        
//        tableView.rowHeight = UITableView.automaticDimension
//    }
//    
//    // MARK: - UITableView 資料來源方法
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfRows(in: section)
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return viewModel.numberOfSections()
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let section = ShopHomeViewModel.Section(rawValue: indexPath.section) else {
//            return UITableViewCell()
//        }
//        
//        switch section {
//        case .banner:
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: BannerCell.reuseIdentifier,
//                for: indexPath
//            ) as! BannerCell
//            cell.configure(with: viewModel.bannerItems)
//            return cell
//            
//
//            
//        case .category:
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: CategoryTableViewCell.reuseIdentifier,
//                for: indexPath
//            ) as! CategoryTableViewCell
//            cell.configure(with: viewModel.categoryViewModel)
//            cell.backgroundColor = .systemOrange
//            return cell
//            
//        case .flashSale:
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: FlashSaleCell.reuseIdentifier,
//                for: indexPath
//            ) as! FlashSaleCell
//            cell.configure(with: viewModel.flashSaleViewModel)
//            
//            cell.onFirstButtonTapped = {
//                print("First button tapped")
//            }
//            cell.onSecondButtonTapped = {
//                print("Second button tapped")
//            }
//            cell.onThirdButtonTapped = {
//                print("Third button tapped")
//            }
//            return cell
//            
//        case .coupon:
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: CouponCell.reuseIdentifier,
//                for: indexPath
//            ) as! CouponCell
//            cell.configure(with: viewModel.couponViewModel)
//            cell.onCouponButtonTapped = {
//                print("Coupon button tapped")
//            }
//            return cell
//        
//        }
//    }
// 
//
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let section = ShopHomeViewModel.Section(rawValue: indexPath.section) else {
//            return 0
//        }
//        
//        // 基準寬度和計算比例
//        let screenWidth = tableView.bounds.width
//        let bannerRatio: CGFloat = 3.4 / 6.4
//        let baseBannerHeight = screenWidth * bannerRatio
//        
//        switch section {
//        case .banner:
//            return baseBannerHeight
//            
//        case .category:
//            // Category Cell 計算參數
//            let spacing: CGFloat = 5
//            let sideMargin: CGFloat = 15
//            let labelHeight: CGFloat = 15
//            
//            // 計算單個 item 的尺寸
//            let availableWidth = screenWidth - sideMargin
//            let itemWidth = (availableWidth - spacing * 4) / 5
//            let itemHeight = itemWidth + labelHeight
//            
//            // 計算總高度（兩行）
//            let rowSpacing: CGFloat = 5
//            let totalHeight = (itemHeight * 2) + rowSpacing + spacing
//            return totalHeight
//            
//        case .flashSale:
//            return baseBannerHeight * 0.65
//            
//        case .coupon:
//            return baseBannerHeight * 0.8
//        }
//        
//
//    }
// 
//
//
//}
//
////import UIKit
////
////class ShopHomeTableViewController: UITableViewController {
////    
////    // MARK: - 屬性
////    private let viewModel = ShopHomeViewModel()
////    
////    private var dynamicIslandHeight: CGFloat {
////        let window = UIApplication.shared.windows.first
////        return window?.safeAreaInsets.top ?? 0
////    }
////     
////    // MARK: - 初始化
////    override init(style: UITableView.Style = .plain) {
////        super.init(style: style)
////    }
////     
////    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
////    
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        
////        setupNavigationBar()
////        setupTableView()
////        bindViewModel()
////        viewModel.fetchData()
////        
////        // 調整 TableView 的內邊距
////        tableView.contentInsetAdjustmentBehavior = .never
////        
////        // 設置滾動指示器的位置
////        tableView.scrollIndicatorInsets = UIEdgeInsets(
////            top: 0,
////            left: 0,
////            bottom: 10,
////            right: 0
////        )
////    }
////    
////    private func setupNavigationBar() {
////        print("ShopHomeTableViewController - setupNavigationBar started")
////        
////        let customNavBar = CustomNavBar(frame: .zero)
////        setupNavBarCallbacks(for: customNavBar)
////        
////        // 移除導航欄的預設外觀
////        navigationController?.navigationBar.shadowImage = UIImage()
////        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
////        
////        // 直接設置導航欄高度
////        navigationController?.navigationBar.frame.size.height = 24
////        
////        // 強制更新導航欄佈局
////        navigationController?.navigationBar.layoutIfNeeded()
////        
////        if #available(iOS 13.0, *) {
////            let appearance = UINavigationBarAppearance()
////            appearance.configureWithOpaqueBackground()
////            appearance.backgroundColor = .white
////            appearance.shadowImage = UIImage()
////            
////            navigationController?.navigationBar.standardAppearance = appearance
////            navigationController?.navigationBar.scrollEdgeAppearance = appearance
////            navigationController?.navigationBar.compactAppearance = appearance
////        }
////        
////        // 設置自定義視圖
////        navigationItem.titleView = customNavBar
////    }
////    
//////    private func setupNavigationBar() {
//////        print("ShopHomeTableViewController - setupNavigationBar started")
//////        
//////        // 使用正確的初始 frame
//////        let customNavBar = CustomNavBar(frame: CGRect(
//////            x: 0,
//////            y: 0,
//////            width: view.bounds.width,
//////            height: 44  // 明確設置高度為 44
//////        ))
//////        
//////        // 設定自訂視圖為導航欄的標題視圖
//////        navigationItem.titleView = customNavBar
//////        
//////        // 確保導航欄樣式正確
//////        if #available(iOS 13.0, *) {
//////            let appearance = UINavigationBarAppearance()
//////            appearance.configureWithOpaqueBackground()
//////            appearance.backgroundColor = .clear
//////            appearance.shadowImage = UIImage() // 移除底部陰影
//////            
//////            // 設置導航列高度
//////            let bounds = UIScreen.main.bounds
//////            appearance.backgroundImage = UIImage()
//////            
//////            navigationController?.navigationBar.standardAppearance = appearance
//////            navigationController?.navigationBar.scrollEdgeAppearance = appearance
//////            navigationController?.navigationBar.compactAppearance = appearance
//////        }
//////        
//////        setupNavBarCallbacks(for: customNavBar)
//////    }
////
////
////    
////    // ShopHomeTableViewController.swift - 清理重複的方法
////    override func viewDidLayoutSubviews() {
////        super.viewDidLayoutSubviews()
////        print("ShopHomeTableViewController - viewDidLayoutSubviews")
////        print("NavigationBar height in layoutSubviews:", navigationController?.navigationBar.frame.height ?? 0)
////    }
////
////    override func viewDidAppear(_ animated: Bool) {
////        super.viewDidAppear(animated)
////        print("ShopHomeTableViewController - viewDidAppear")
////        print("Final NavigationBar height:", navigationController?.navigationBar.frame.height ?? 0)
////        print("Final CustomNavBar frame:", navigationItem.titleView?.frame ?? .zero)
////    }
////    
////    private func setupNavBarCallbacks(for customNavBar: CustomNavBar) {
////        customNavBar.onSearchTextChanged = { [weak self] text in
////            print("Search text changed: \(text)")
////        }
////        
////        customNavBar.onSearchButtonTapped = { [weak self] in
////            print("Search button tapped")
////        }
////        
////        customNavBar.onCameraButtonTapped = { [weak self] in
////            print("Camera button tapped")
////        }
////        
////        customNavBar.onCartButtonTapped = { [weak self] in
////            print("Cart button tapped")
////        }
////        
////        customNavBar.onChatButtonTapped = { [weak self] in
////            print("Chat button tapped")
////        }
////    }
////    
////    private func bindViewModel() {
////        viewModel.onDataUpdate = { [weak self] in
////            DispatchQueue.main.async {
////                self?.tableView.reloadData()
////                self?.refreshControl?.endRefreshing()
////            }
////        }
////        
////        viewModel.onError = { [weak self] error in
////            DispatchQueue.main.async {
////                self?.showError(message: error)
////                self?.refreshControl?.endRefreshing()
////            }
////        }
////    }
////    
////    // MARK: - 更新資料方法
////    @objc private func refreshData() {
////        viewModel.fetchData()
////    }
////    
////    private func showError(message: String) {
////        let alert = UIAlertController(
////            title: "錯誤",
////            message: message,
////            preferredStyle: .alert
////        )
////        alert.addAction(UIAlertAction(title: "確定", style: .default))
////        present(alert, animated: true)
////    }
////    
////    private func setupTableView() {
////        tableView.backgroundColor = .systemBackground
////        tableView.separatorStyle = .none
////        
////        // 註冊所有需要的 Cell
////        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.reuseIdentifier)
////        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
////        tableView.register(FlashSaleCell.self, forCellReuseIdentifier: FlashSaleCell.reuseIdentifier)
////        tableView.register(CouponCell.self, forCellReuseIdentifier: CouponCell.reuseIdentifier)
////        
////        tableView.rowHeight = UITableView.automaticDimension
////    }
////    
////    // MARK: - UITableView 資料來源方法
////    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return viewModel.numberOfRows(in: section)
////    }
////    
////    override func numberOfSections(in tableView: UITableView) -> Int {
////        return viewModel.numberOfSections()
////    }
////    
////    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        guard let section = ShopHomeViewModel.Section(rawValue: indexPath.section) else {
////            return UITableViewCell()
////        }
////        
////        switch section {
////        case .banner:
////            let cell = tableView.dequeueReusableCell(
////                withIdentifier: BannerCell.reuseIdentifier,
////                for: indexPath
////            ) as! BannerCell
////            cell.configure(with: viewModel.bannerItems)
////            return cell
////            
////        case .category:
////            let cell = tableView.dequeueReusableCell(
////                withIdentifier: CategoryTableViewCell.reuseIdentifier,
////                for: indexPath
////            ) as! CategoryTableViewCell
////            cell.configure(with: viewModel.categoryViewModel)
////            cell.backgroundColor = .systemOrange
////            return cell
////            
////        case .flashSale:
////            let cell = tableView.dequeueReusableCell(
////                withIdentifier: FlashSaleCell.reuseIdentifier,
////                for: indexPath
////            ) as! FlashSaleCell
////            cell.configure(with: viewModel.flashSaleViewModel)
////            cell.onFirstButtonTapped = {
////                print("First button tapped")
////            }
////            cell.onSecondButtonTapped = {
////                print("Second button tapped")
////            }
////            cell.onThirdButtonTapped = {
////                print("Third button tapped")
////            }
////            return cell
////            
////        case .coupon:
////            let cell = tableView.dequeueReusableCell(
////                withIdentifier: CouponCell.reuseIdentifier,
////                for: indexPath
////            ) as! CouponCell
////            cell.configure(with: viewModel.couponViewModel)
////            cell.onCouponButtonTapped = {
////                print("Coupon button tapped")
////            }
////            return cell
////        }
////    }
////    
////    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        guard let section = ShopHomeViewModel.Section(rawValue: indexPath.section) else {
////            return 0
////        }
////        
////        // 基準寬度和計算比例
////        let screenWidth = tableView.bounds.width
////        let bannerRatio: CGFloat = 3.4 / 6.4
////        let baseBannerHeight = screenWidth * bannerRatio
////        
////        switch section {
////        case .banner:
////            return baseBannerHeight
////            
////        case .category:
////            // Category Cell 計算參數
////            let spacing: CGFloat = 5
////            let sideMargin: CGFloat = 15
////            let labelHeight: CGFloat = 15
////            
////            // 計算單個 item 的尺寸
////            let availableWidth = screenWidth - sideMargin
////            let itemWidth = (availableWidth - spacing * 4) / 5
////            let itemHeight = itemWidth + labelHeight
////            
////            // 計算總高度（兩行）
////            let rowSpacing: CGFloat = 5
////            let totalHeight = (itemHeight * 2) + rowSpacing + spacing
////            return totalHeight
////            
////        case .flashSale:
////            return baseBannerHeight * 0.65
////            
////        case .coupon:
////            return baseBannerHeight * 0.8
////        }
////        
////
////    }
//// 
////
////
////}
