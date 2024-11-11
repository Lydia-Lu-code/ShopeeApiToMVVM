//
//  HomeViewModel.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/7.
//

import Foundation

class HomeViewModel {    
    
    enum Section: Int, CaseIterable {
        case banner
        case category  // 添加 category section
    }
    
    // MARK: - 屬性
    private var products: [Product] = []
    private var banners: [BannerItem] = []
    private(set) var categoryViewModel: CategoryViewModel
    
    init() {
        let categoryItems: [[CategoryItem]] = [
            [
                CategoryItem(emoji: "🛍️", title: "每日特賣"),
                CategoryItem(emoji: "🎮", title: "遊戲"),
                CategoryItem(emoji: "👕", title: "服飾"),
                CategoryItem(emoji: "📱", title: "手機"),
                CategoryItem(emoji: "💄", title: "美妝")
            ],
            [
                CategoryItem(emoji: "🏠", title: "居家"),
                CategoryItem(emoji: "📚", title: "書籍"),
                CategoryItem(emoji: "🎵", title: "音樂"),
                CategoryItem(emoji: "🖥️", title: "電腦"),
                CategoryItem(emoji: "🎁", title: "禮品")
            ]
        ]
        
        self.categoryViewModel = CategoryViewModel(categories: categoryItems)
        setupMockData()
    }


    
    
    
    var onDataUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    

    
    // MARK: - 公開方法
    var bannerItems: [BannerItem] {
        return banners
    }
    


    
    func numberOfSections() -> Int {
        return Section.allCases.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .banner:
            return 1
        case .category:
            return 1
        }
    }
    
//    func numberOfSections() -> Int {
//        return 2 // Banner section + Products section
//    }
//
//    func numberOfRows(in section: Int) -> Int {
//        if section == 0 { // Banner section
//            return 1
//        } else { // Products section
//            return products.count
//        }
//    }

    
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
