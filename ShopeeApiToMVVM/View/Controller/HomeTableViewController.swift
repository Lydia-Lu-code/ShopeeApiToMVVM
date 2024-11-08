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
     
     // MARK: - 初始化
     override init(style: UITableView.Style = .plain) {
         super.init(style: style)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     // MARK: - 生命週期方法
     override func viewDidLoad() {
         super.viewDidLoad()
         setupNavigationBar()
         setupTableView()
         bindViewModel()
         viewModel.fetchProducts()
     }
     
     // MARK: - 私有方法
     private func setupNavigationBar() {
         title = "蝦皮商品列表"
         navigationController?.navigationBar.prefersLargeTitles = true
     }
     
     private func setupTableView() {
         // 設定基本屬性
         tableView.backgroundColor = .systemBackground
         tableView.separatorStyle = .none  // 移除分隔線
         
         // 註冊 Cell
         tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
         tableView.register(FeaturedProductCell.self, forCellReuseIdentifier: "FeaturedProductCell")
         
         // 設定自動調整高度
         tableView.rowHeight = UITableView.automaticDimension
         tableView.estimatedRowHeight = 140  // 調整預估高度
         
         // 設定下拉更新
         let refreshControl = UIRefreshControl()
         refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
         self.refreshControl = refreshControl
         
         // 設定邊距
         tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
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
    
    @objc private func refreshData() {
        viewModel.fetchProducts()
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
    
    // MARK: - UITableView 資料來源方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = viewModel.product(at: indexPath.row)
        
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
            cell.configure(with: product)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedProductCell", for: indexPath) as! FeaturedProductCell
            cell.configure(with: product)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }

}
