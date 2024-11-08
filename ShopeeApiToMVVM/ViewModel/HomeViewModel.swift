//
//  HomeViewModel.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/7.
//

import Foundation

class HomeViewModel {
    // MARK: - 屬性
    private var products: [Product] = []
    var onDataUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    
    // MARK: - 初始化
    init() {
        // 加入測試資料
        products = [
            Product(
                id: 1,
                name: "iPhone 15 Pro Max",
                description: "最新款 iPhone，搭載 A17 Pro 晶片，提供卓越效能與專業級相機系統",
                price: 45900,
                imageUrl: "https://example.com/iphone.jpg"
            ),
            Product(
                id: 2,
                name: "MacBook Air M2",
                description: "輕薄設計，驚人效能。配備 M2 晶片，續航力長達 18 小時",
                price: 39900,
                imageUrl: "https://example.com/macbook.jpg"
            ),
            Product(
                id: 3,
                name: "AirPods Pro",
                description: "主動降噪耳機，提供絕佳的音質與舒適的配戴體驗",
                price: 7990,
                imageUrl: "https://example.com/airpods.jpg"
            ),
            Product(
                id: 4,
                name: "Apple Watch Series 9",
                description: "更聰明、更強大、更貼心的智慧型手錶",
                price: 13900,
                imageUrl: "https://example.com/watch.jpg"
            )
        ]
    }
    
    // MARK: - 公開方法
    func fetchProducts() {
        // 模擬網路請求
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.onDataUpdate?()
        }
    }
    
    func numberOfRows() -> Int {
        return products.count
    }
    
    func product(at index: Int) -> Product {
        return products[index]
    }
}

//class HomeViewModel {
//    // MARK: - 屬性
//    private var products: [Product] = []
//    var onDataUpdate: (() -> Void)?
//    var onError: ((String) -> Void)?
//    
//    // MARK: - 公開方法
//    func fetchProducts() {
//        ShopeeAPIService.shared.getProducts { [weak self] result in
//            switch result {
//            case .success(let products):
//                self?.products = products
//                self?.onDataUpdate?()
//            case .failure(let error):
//                self?.onError?(error.localizedDescription)
//            }
//        }
//    }
//    
//    func numberOfRows() -> Int {
//        return products.count
//    }
//    
//    func product(at index: Int) -> Product {
//        return products[index]
//    }
//}
