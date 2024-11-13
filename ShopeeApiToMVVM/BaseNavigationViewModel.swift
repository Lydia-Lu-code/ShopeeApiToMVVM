//
//  BaseNavigationViewModel.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/13.
//

import Foundation

protocol NavBarActionHandling {
    var onSearchTextChanged: ((String) -> Void)? { get set }
    var onSearchButtonTapped: (() -> Void)? { get set }
    var onCameraButtonTapped: (() -> Void)? { get set }
    var onCartButtonTapped: (() -> Void)? { get set }
    var onChatButtonTapped: (() -> Void)? { get set }
    
    func handleSearchTextChanged(_ text: String)
    func handleSearchButtonTapped()
    func handleCameraButtonTapped()
    func handleCartButtonTapped()
    func handleChatButtonTapped()
}

class BaseNavigationViewModel: NavBarActionHandling {
    var onSearchTextChanged: ((String) -> Void)?
    var onSearchButtonTapped: (() -> Void)?
    var onCameraButtonTapped: (() -> Void)?
    var onCartButtonTapped: (() -> Void)?
    var onChatButtonTapped: (() -> Void)?
    
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
