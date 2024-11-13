import UIKit

class MallViewController: UIViewController, NavigationBarConfigurable {
    private let viewModel = MallViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
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
    

}

