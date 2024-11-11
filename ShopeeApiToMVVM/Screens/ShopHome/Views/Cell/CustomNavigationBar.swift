////
////  CustomNavigationBar.swift
////  ShopeeApiToMVVM
////
////  Created by Lydia Lu on 2024/11/11.
////
//
//import UIKit
//
//// CustomNavigationBar.swift
//class CustomNavigationBar: UIView {
//    // MARK: - UI Components
//    private let searchContainer: UIView = {
//        let view = UIView()
//        view.backgroundColor = .clear
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let searchBoxContainer: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.layer.cornerRadius = 8
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let searchTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "搜尋"
//        textField.borderStyle = .none
//        textField.backgroundColor = .clear
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//    
//    private let searchIconButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("🔍", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 16)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let cameraButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("📸", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 16)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let cartButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("🛒", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 24)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let chatButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("💬", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 24)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    // MARK: - Initialization
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Setup
//    private func setupUI() {
//        backgroundColor = .systemBackground
//        
//        addSubview(searchContainer)
//        searchContainer.addSubview(searchBoxContainer)
//        searchBoxContainer.addSubview(searchIconButton)
//        searchBoxContainer.addSubview(searchTextField)
//        searchBoxContainer.addSubview(cameraButton)
//        searchContainer.addSubview(cartButton)
//        searchContainer.addSubview(chatButton)
//        
//        NSLayoutConstraint.activate([
//            // 容器視圖約束
//            searchContainer.topAnchor.constraint(equalTo: topAnchor),
//            searchContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
//            searchContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
//            searchContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
//            
//            // 搜尋框容器約束
//            searchBoxContainer.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 16),
//            searchBoxContainer.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: -10),
//            searchBoxContainer.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
//            searchBoxContainer.heightAnchor.constraint(equalToConstant: 36),
//            
//            // 搜尋圖標按鈕約束
//            searchIconButton.leadingAnchor.constraint(equalTo: searchBoxContainer.leadingAnchor, constant: 8),
//            searchIconButton.centerYAnchor.constraint(equalTo: searchBoxContainer.centerYAnchor),
//            searchIconButton.widthAnchor.constraint(equalToConstant: 24),
//            searchIconButton.heightAnchor.constraint(equalToConstant: 24),
//            
//            // 相機按鈕約束
//            cameraButton.trailingAnchor.constraint(equalTo: searchBoxContainer.trailingAnchor, constant: -8),
//            cameraButton.centerYAnchor.constraint(equalTo: searchBoxContainer.centerYAnchor),
//            cameraButton.widthAnchor.constraint(equalToConstant: 24),
//            cameraButton.heightAnchor.constraint(equalToConstant: 24),
//            
//            // 搜尋框約束
//            searchTextField.leadingAnchor.constraint(equalTo: searchIconButton.trailingAnchor, constant: 8),
//            searchTextField.trailingAnchor.constraint(equalTo: cameraButton.leadingAnchor, constant: -8),
//            searchTextField.topAnchor.constraint(equalTo: searchBoxContainer.topAnchor),
//            searchTextField.bottomAnchor.constraint(equalTo: searchBoxContainer.bottomAnchor),
//            
//            // 購物車按鈕約束
//            cartButton.widthAnchor.constraint(equalToConstant: 44),
//            cartButton.heightAnchor.constraint(equalToConstant: 44),
//            cartButton.trailingAnchor.constraint(equalTo: chatButton.leadingAnchor, constant: -10),
//            cartButton.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor),
//            
//            // 聊天按鈕約束
//            chatButton.widthAnchor.constraint(equalToConstant: 44),
//            chatButton.heightAnchor.constraint(equalToConstant: 44),
//            chatButton.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor, constant: -16),
//            chatButton.centerYAnchor.constraint(equalTo: searchContainer.centerYAnchor)
//        ])
//    }
//}
