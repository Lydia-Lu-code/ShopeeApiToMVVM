//
//  MallViewModel.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/13.
//

import Foundation

class MallViewModel {
    // MARK: - Properties
    var onSearchTextChanged: ((String) -> Void)?
    var onSearchButtonTapped: (() -> Void)?
    var onCameraButtonTapped: (() -> Void)?
    var onCartButtonTapped: (() -> Void)?
    var onChatButtonTapped: (() -> Void)?
    
    // MARK: - Methods
    func handleSearchTextChanged(_ text: String) {
        print("Search text changed: \(text)")
        onSearchTextChanged?(text)
    }
    
    func handleSearchButtonTapped() {
        print("Search button tapped")
        onSearchButtonTapped?()
    }
    
    func handleCameraButtonTapped() {
        print("Camera button tapped")
        onCameraButtonTapped?()
    }
    
    func handleCartButtonTapped() {
        print("Cart button tapped")
        onCartButtonTapped?()
    }
    
    func handleChatButtonTapped() {
        print("Chat button tapped")
        onChatButtonTapped?()
    }
}
