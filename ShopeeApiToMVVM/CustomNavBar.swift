import UIKit

class CustomNavBar: UIView {
    // MARK: - UI Components
    private let searchBoxContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white  // 白色背景
        view.layer.cornerRadius = 0    // 移除圓角，變成長方形
        view.layer.borderWidth = 1     // 邊框寬度
        view.layer.borderColor = UIColor.systemOrange.cgColor  // 橘色邊框
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "搜尋"
        textField.borderStyle = .none
        textField.backgroundColor = .white
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
        print("CustomNavBar - init frame:", frame)
        setupUI()
        setupActions()
        
    }
    
    // 搜尋欄上下移動
    override func layoutSubviews() {
        super.layoutSubviews()
        print("CustomNavBar - layoutSubviews bounds:", bounds)
        print("CustomNavBar - layoutSubviews frame:", frame)
        transform = CGAffineTransform(translationX: 0, y: -40)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        print("CustomNavBar - setupUI started")
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(searchBoxContainer)
        searchBoxContainer.addSubview(searchIconButton)
        searchBoxContainer.addSubview(searchTextField)
        searchBoxContainer.addSubview(cameraButton)
        addSubview(cartButton)
        addSubview(chatButton)
        
        // 檢查 searchBoxContainer 的設定
        print("CustomNavBar - searchBoxContainer backgroundColor:", searchBoxContainer.backgroundColor ?? "nil")
        print("CustomNavBar - searchBoxContainer borderWidth:", searchBoxContainer.layer.borderWidth)
        print("CustomNavBar - searchBoxContainer borderColor:", searchBoxContainer.layer.borderColor ?? "nil")
        print("CustomNavBar - Constraints being set")
        
        
        NSLayoutConstraint.activate([
            // 自身的寬度和高度約束
            widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 10), // 減去左右邊距
            heightAnchor.constraint(equalToConstant: 36), // 調整這個值

            
            // Search Box Container - 調整約束
            searchBoxContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBoxContainer.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: -10),
            searchBoxContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchBoxContainer.heightAnchor.constraint(equalToConstant: 36),
//            searchBoxContainer.heightAnchor.constraint(equalToConstant: 0),
            
            
            // 其他約束保持不變
            searchIconButton.leadingAnchor.constraint(equalTo: searchBoxContainer.leadingAnchor, constant: 8),
            searchIconButton.centerYAnchor.constraint(equalTo: searchBoxContainer.centerYAnchor),
            searchIconButton.widthAnchor.constraint(equalToConstant: 24),
            searchIconButton.heightAnchor.constraint(equalToConstant: 24),
            
            cameraButton.trailingAnchor.constraint(equalTo: searchBoxContainer.trailingAnchor, constant: -8),
            cameraButton.centerYAnchor.constraint(equalTo: searchBoxContainer.centerYAnchor),
            cameraButton.widthAnchor.constraint(equalToConstant: 24),
            cameraButton.heightAnchor.constraint(equalToConstant: 24),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchIconButton.trailingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: cameraButton.leadingAnchor, constant: -8),
            searchTextField.topAnchor.constraint(equalTo: searchBoxContainer.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: searchBoxContainer.bottomAnchor),
            
            cartButton.widthAnchor.constraint(equalToConstant: 24),
            cartButton.heightAnchor.constraint(equalToConstant: 24),
            cartButton.trailingAnchor.constraint(equalTo: chatButton.leadingAnchor, constant: -10),
            cartButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            chatButton.widthAnchor.constraint(equalToConstant: 24),
            chatButton.heightAnchor.constraint(equalToConstant: 24),
            chatButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            chatButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        print("CustomNavBar - setupUI completed")
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

