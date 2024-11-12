//
//  CustomNavBar.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/12.
//

import UIKit

class CustomNavBar: UIView {
    // MARK: - UI Components
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
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let searchIconButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🔍", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("📸", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    // MARK: - Callbacks
    var onSearchTextChanged: ((String) -> Void)?
    var onSearchButtonTapped: (() -> Void)?
    var onCameraButtonTapped: (() -> Void)?
    var onCartButtonTapped: (() -> Void)?
    var onChatButtonTapped: (() -> Void)?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(searchBoxContainer)
        searchBoxContainer.addSubview(searchIconButton)
        searchBoxContainer.addSubview(searchTextField)
        searchBoxContainer.addSubview(cameraButton)
        addSubview(cartButton)
        addSubview(chatButton)
        
        NSLayoutConstraint.activate([
            // Search Box Container
            searchBoxContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchBoxContainer.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: -10),
            searchBoxContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchBoxContainer.heightAnchor.constraint(equalToConstant: 36),
            
            // Search Icon
            searchIconButton.leadingAnchor.constraint(equalTo: searchBoxContainer.leadingAnchor, constant: 8),
            searchIconButton.centerYAnchor.constraint(equalTo: searchBoxContainer.centerYAnchor),
            searchIconButton.widthAnchor.constraint(equalToConstant: 24),
            searchIconButton.heightAnchor.constraint(equalToConstant: 24),
            
            // Camera Button
            cameraButton.trailingAnchor.constraint(equalTo: searchBoxContainer.trailingAnchor, constant: -8),
            cameraButton.centerYAnchor.constraint(equalTo: searchBoxContainer.centerYAnchor),
            cameraButton.widthAnchor.constraint(equalToConstant: 24),
            cameraButton.heightAnchor.constraint(equalToConstant: 24),
            
            // Search TextField
            searchTextField.leadingAnchor.constraint(equalTo: searchIconButton.trailingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: cameraButton.leadingAnchor, constant: -8),
            searchTextField.topAnchor.constraint(equalTo: searchBoxContainer.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: searchBoxContainer.bottomAnchor),
            
            // Cart Button
            cartButton.widthAnchor.constraint(equalToConstant: 44),
            cartButton.heightAnchor.constraint(equalToConstant: 44),
            cartButton.trailingAnchor.constraint(equalTo: chatButton.leadingAnchor, constant: -10),
            cartButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Chat Button
            chatButton.widthAnchor.constraint(equalToConstant: 44),
            chatButton.heightAnchor.constraint(equalToConstant: 44),
            chatButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            chatButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupActions() {
        searchTextField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        searchIconButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        chatButton.addTarget(self, action: #selector(chatButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    @objc private func searchTextChanged() {
        onSearchTextChanged?(searchTextField.text ?? "")
    }
    
    @objc private func searchButtonTapped() {
        onSearchButtonTapped?()
    }
    
    @objc private func cameraButtonTapped() {
        onCameraButtonTapped?()
    }
    
    @objc private func cartButtonTapped() {
        onCartButtonTapped?()
    }
    
    @objc private func chatButtonTapped() {
        onChatButtonTapped?()
    }
    
    // MARK: - Public Methods
    func setPlaceholder(_ text: String) {
        searchTextField.placeholder = text
    }
    
    func getSearchText() -> String {
        return searchTextField.text ?? ""
    }
}
