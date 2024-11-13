import UIKit

class MallViewController: UIViewController, NavigationBarConfigurable {
    private let viewModel = MallViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        bindViewModel()
    }
    
        private func setupView() {
            view.backgroundColor = .systemBackground
        }
    
    func setupNavBarCallbacks(for customNavBar: CustomNavBar) {
        customNavBar.onSearchTextChanged = { [weak self] text in
            self?.viewModel.handleSearchTextChanged(text)
        }
        customNavBar.onSearchButtonTapped = { [weak self] in
            self?.viewModel.handleSearchButtonTapped()
        }
        customNavBar.onCameraButtonTapped = { [weak self] in
            self?.viewModel.handleCameraButtonTapped()
        }
        customNavBar.onCartButtonTapped = { [weak self] in
            self?.viewModel.handleCartButtonTapped()
        }
        customNavBar.onChatButtonTapped = { [weak self] in
            self?.viewModel.handleChatButtonTapped()
        }
    }
    
    private func bindViewModel() {
        // 綁定特定於 Mall 的功能
    }
}


//class MallViewController: UIViewController,BaseNavigationViewModel {
//    
//    // MARK: - Properties
//    private let viewModel = MallViewModel()
//    private let customNavBar = CustomNavBar()
//    
//    private var dynamicIslandHeight: CGFloat {
//        let window = UIApplication.shared.windows.first
//        return window?.safeAreaInsets.top ?? 0
//    }
//    
//    // MARK: - Lifecycle Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        setupNavigationBar()
//        bindViewModel()
//    }
//    
//    // MARK: - Setup Methods
//    private func setupView() {
//        view.backgroundColor = .systemBackground
//    }
//    
//    private func setupNavigationBar() {
//        print("MallViewController - setupNavigationBar started")
//
//        let customNavBar = CustomNavBar(frame: .zero)
//        setupNavBarCallbacks(for: customNavBar)
//        
//        print("NavigationBar height before:", navigationController?.navigationBar.frame.height ?? 0)
//            
//        // 移除導航欄的預設外觀
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        
//        // 設定自訂視圖為導航欄的標題視圖
//        navigationItem.titleView = customNavBar
//        
//        // 調整導航欄的外觀和高度
//        if #available(iOS 13.0, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = .clear
//            
//            navigationController?.navigationBar.standardAppearance = appearance
//            navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        }
//    }
//    
//    private func bindViewModel() {
//        viewModel.onSearchTextChanged = { [weak self] text in
//            // 處理搜尋文字變更的 UI 更新
//        }
//        
//        viewModel.onSearchButtonTapped = { [weak self] in
//            // 處理搜尋按鈕點擊的 UI 更新
//        }
//        
//        viewModel.onCameraButtonTapped = { [weak self] in
//            // 處理相機按鈕點擊的 UI 更新
//        }
//        
//        viewModel.onCartButtonTapped = { [weak self] in
//            // 處理購物車按鈕點擊的 UI 更新
//        }
//        
//        viewModel.onChatButtonTapped = { [weak self] in
//            // 處理聊天按鈕點擊的 UI 更新
//        }
//    }
//    
//    private func setupNavBarCallbacks(for customNavBar: CustomNavBar) {
//        customNavBar.onSearchTextChanged = { [weak self] text in
//            self?.viewModel.handleSearchTextChanged(text)
//        }
//        
//        customNavBar.onSearchButtonTapped = { [weak self] in
//            self?.viewModel.handleSearchButtonTapped()
//        }
//        
//        customNavBar.onCameraButtonTapped = { [weak self] in
//            self?.viewModel.handleCameraButtonTapped()
//        }
//        
//        customNavBar.onCartButtonTapped = { [weak self] in
//            self?.viewModel.handleCartButtonTapped()
//        }
//        
//        customNavBar.onChatButtonTapped = { [weak self] in
//            self?.viewModel.handleChatButtonTapped()
//        }
//    }
//}

//class MallViewController: UIViewController {
//    
//    // MARK: - Properties
//    private let customNavBar = CustomNavBar()
//    
//    private var dynamicIslandHeight: CGFloat {
//        let window = UIApplication.shared.windows.first
//        return window?.safeAreaInsets.top ?? 0
//    }
//    
//    // MARK: - Lifecycle Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        setupCustomNavBar()
//    }
//    
//    // MARK: - Setup Methods
//    private func setupView() {
//        view.backgroundColor = .systemBackground
//    }
//    
//    private func setupCustomNavBar() {
//        view.addSubview(customNavBar)
//        customNavBar.backgroundColor = .clear
//        
//        NSLayoutConstraint.activate([
//            customNavBar.topAnchor.constraint(equalTo: view.topAnchor, constant: dynamicIslandHeight),
//            customNavBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            customNavBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            customNavBar.heightAnchor.constraint(equalToConstant: 50)
//        ])
//        
//        setupNavBarCallbacks()
//    }
//    
//    private func setupNavBarCallbacks() {
//        customNavBar.onSearchTextChanged = { [weak self] text in
//            print("Search text changed: \(text)")
//        }
//        
//        customNavBar.onSearchButtonTapped = { [weak self] in
//            print("Search button tapped")
//        }
//        
//        customNavBar.onCameraButtonTapped = { [weak self] in
//            print("Camera button tapped")
//        }
//        
//        customNavBar.onCartButtonTapped = { [weak self] in
//            print("Cart button tapped")
//        }
//        
//        customNavBar.onChatButtonTapped = { [weak self] in
//            print("Chat button tapped")
//        }
//    }
//}
