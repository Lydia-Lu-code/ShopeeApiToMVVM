//
//  ViewController.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/7.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    
    // MARK: - 屬性
    private let viewModel = HomeViewModel()
    
    // 添加屬性來儲存動態島高度
    private var dynamicIslandHeight: CGFloat {
        // 獲取視窗的安全區域頂部高度
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.top ?? 0
    }
    
    private let searchBoxContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "搜尋"
        textField.borderStyle = .none // 移除邊框樣式
        textField.backgroundColor = .clear // 背景設為透明
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // 新增搜尋框左側按鈕
    private let searchIconButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🔍", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // 新增搜尋框右側按鈕
    private let cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("📸", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    private let searchContainer: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemBackground
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    
    private let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🛒", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let chatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("💬", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    enum CellType {
        case banner    // 新增
        case product
        case featured
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
        setupSearchBar()
        setupNavigationBar()
        setupTableView()
        bindViewModel()
        viewModel.fetchData()
        
        // 調整 TableView 的內邊距，為 searchContainer 留出空間
        let searchBarHeight: CGFloat = 50
        tableView.contentInset = UIEdgeInsets(
            top: searchBarHeight,
            left: 0,
            bottom: 10,
            right: 0
        )
        
        // 設置滾動指示器的位置，避免被 searchContainer 遮擋
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupNavigationBar()
//        setupSearchBar()
//        setupTableView()
//        bindViewModel()
//        viewModel.fetchData()
//        
//        // 調整 TableView 的內邊距
//        tableView.contentInsetAdjustmentBehavior = .never // 關閉自動調整
//        let window = UIApplication.shared.windows.first
//        let topPadding = window?.safeAreaInsets.top ?? 0
//        
//        // 設定 TableView 的內邊距
//        tableView.contentInset = UIEdgeInsets(
//            top: topPadding - dynamicIslandHeight, // 使用安全區域的頂部間距
//            left: 0,
//            bottom: 10,
//            right: 0
//        )
//        
//        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
//    }
    
    private func setupNavigationBar() {
        // 隱藏導航欄
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    private func setupSearchBar() {
        view.addSubview(searchContainer)
        searchContainer.addSubview(searchBoxContainer)
        searchBoxContainer.addSubview(searchIconButton)
        searchBoxContainer.addSubview(searchTextField)
        searchBoxContainer.addSubview(cameraButton)
        searchContainer.addSubview(cartButton)
        searchContainer.addSubview(chatButton)
        
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0
        
        NSLayoutConstraint.activate([
            // 容器視圖約束
            searchContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding),
            searchContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchContainer.heightAnchor.constraint(equalToConstant: 50),
            
            // 搜尋框容器約束
            searchBoxContainer.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 16),
            searchBoxContainer.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: -10),
            searchBoxContainer.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
            searchBoxContainer.heightAnchor.constraint(equalToConstant: 36),
            
            // 搜尋圖標按鈕約束
            searchIconButton.leadingAnchor.constraint(equalTo: searchBoxContainer.leadingAnchor, constant: 8),
            searchIconButton.centerYAnchor.constraint(equalTo: searchBoxContainer.centerYAnchor),
            searchIconButton.widthAnchor.constraint(equalToConstant: 24),
            searchIconButton.heightAnchor.constraint(equalToConstant: 24),
            
            // 相機按鈕約束
            cameraButton.trailingAnchor.constraint(equalTo: searchBoxContainer.trailingAnchor, constant: -8),
            cameraButton.centerYAnchor.constraint(equalTo: searchBoxContainer.centerYAnchor),
            cameraButton.widthAnchor.constraint(equalToConstant: 24),
            cameraButton.heightAnchor.constraint(equalToConstant: 24),
            
            // 搜尋框約束
            searchTextField.leadingAnchor.constraint(equalTo: searchIconButton.trailingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: cameraButton.leadingAnchor, constant: -8),
            searchTextField.topAnchor.constraint(equalTo: searchBoxContainer.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: searchBoxContainer.bottomAnchor),
            
            // 購物車按鈕約束
            cartButton.widthAnchor.constraint(equalToConstant: 44),
            cartButton.heightAnchor.constraint(equalToConstant: 44),
            cartButton.trailingAnchor.constraint(equalTo: chatButton.leadingAnchor, constant: -10),
            cartButton.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
            
            // 聊天按鈕約束
            chatButton.widthAnchor.constraint(equalToConstant: 44),
            chatButton.heightAnchor.constraint(equalToConstant: 44),
            chatButton.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor, constant: -16),
            chatButton.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor)
        ])
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
        guard let section = HomeViewModel.Section(rawValue: indexPath.section) else {
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
        }
    }
 

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = HomeViewModel.Section(rawValue: indexPath.section) else {
            return 0
        }
        
        switch section {
        case .banner:
            let width = tableView.bounds.width
            return width * (3.4 / 6.4) + 40
        case .category:
            // 計算單個 CollectionViewCell 的高度
            let spacing: CGFloat = 10 // Cell 之間的間距
            let totalWidth = tableView.bounds.width - 20 // 減去左右邊距
            let itemWidth = (totalWidth - spacing * 4) / 5
            let itemHeight = itemWidth + 20 // CollectionViewCell 的高度
            
            // 計算兩行的總高度：
            // (單個 Cell 高度 × 2) + 中間間距 + 上下邊距
            let totalHeight = (itemHeight * 2) + spacing + 20 // 20 是上下邊距總和
            
            return totalHeight
        }
    }
 


}
