import UIKit

class MallViewController: UIViewController {
    
    // MARK: - Properties
    private let customNavBar = CustomNavBar()
    
    private var dynamicIslandHeight: CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.top ?? 0
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCustomNavBar()
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupCustomNavBar() {
        view.addSubview(customNavBar)
        customNavBar.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.topAnchor, constant: dynamicIslandHeight),
            customNavBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        setupNavBarCallbacks()
    }
    
    private func setupNavBarCallbacks() {
        customNavBar.onSearchTextChanged = { [weak self] text in
            print("Search text changed: \(text)")
        }
        
        customNavBar.onSearchButtonTapped = { [weak self] in
            print("Search button tapped")
        }
        
        customNavBar.onCameraButtonTapped = { [weak self] in
            print("Camera button tapped")
        }
        
        customNavBar.onCartButtonTapped = { [weak self] in
            print("Cart button tapped")
        }
        
        customNavBar.onChatButtonTapped = { [weak self] in
            print("Chat button tapped")
        }
    }
}
