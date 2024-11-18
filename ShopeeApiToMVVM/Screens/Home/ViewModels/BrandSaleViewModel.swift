//
//  brandSaleViewModel.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/13.
//

import Foundation
import UIKit

struct BrandImageItem {
    let imageUrl: String
    let title: String
}

class BrandSaleViewModel {
    private(set) var brandImages: [BrandImageItem]
    let title: String
    
    init(title: String = "品牌特殺", brandImages: [BrandImageItem] = []) {
        self.title = title
        self.brandImages = brandImages
    }
    
    // 如果需要點擊處理
    var onBrandButtonTapped: (() -> Void)?
    var onImageTapped: ((Int) -> Void)?
}
