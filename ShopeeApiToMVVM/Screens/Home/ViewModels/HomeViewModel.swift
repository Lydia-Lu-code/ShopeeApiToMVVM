//
//  HomeViewModel.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/7.
//

import Foundation

class HomeViewModel {
    // MARK: - 列舉
    enum Section: Int {
        case banner
        case products
    }
    
    // MARK: - 屬性
    private var products: [Product] = []
    private var banners: [BannerItem] = []
    
    var onDataUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    
    // MARK: - 初始化
    init() {
        setupMockData()
    }
    
    // MARK: - 公開方法
    var bannerItems: [BannerItem] {
        return banners
    }
    
    func numberOfSections() -> Int {
        return 2 // Banner section + Products section
    }

    func numberOfRows(in section: Int) -> Int {
        if section == 0 { // Banner section
            return 1
        } else { // Products section
            return products.count
        }
    }

    
    func product(at index: Int) -> Product {
        return products[index]
    }
    
    // 將 fetchProducts 改為公開方法
    func fetchProducts() {
        // 模擬網路請求
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.onDataUpdate?()
        }
    }
    
    // 同時提供一個通用的資料獲取方法
    func fetchData() {
        fetchProducts()
        // 之後可以在這裡加入獲取 banner 的邏輯
    }
    
    private func setupMockData() {
        // Banner 測試資料
        banners = (1...13).map { index in
            BannerItem(
                id: index,
                imageUrl: "https://picsum.photos/640/340?random=\(index)",
                link: "https://example.com/promo\(index)",
                title: "Banner \(index)"
            )
        }
        
        // 暫時清空商品資料
        products = []
    }
    
}
