//
//  CategoryViewModel.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/11.
//

import Foundation

class CategoryViewModel {
    private let categories: [[CategoryItem]]
    
    init(categories: [[CategoryItem]]) {
        self.categories = categories
    }
    
    var numberOfSections: Int {
        return 2
    }
    
    func numberOfItems(in section: Int) -> Int {
        return 5
    }
    
    func item(at indexPath: IndexPath) -> CategoryItem {
        return categories[indexPath.section][indexPath.row]
    }
}
