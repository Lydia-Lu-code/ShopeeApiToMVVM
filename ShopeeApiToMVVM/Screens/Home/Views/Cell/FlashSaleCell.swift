import UIKit

class FlashSaleCell: UITableViewCell {
    static let reuseIdentifier = "FlashSaleCell"
    
    // MARK: - UI Components
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let firstButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("限時搶購", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let secondButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.setTitle("商城優惠", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let thirdButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.setTitle("品牌特賣", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Callbacks
    var onFirstButtonTapped: (() -> Void)?
    var onSecondButtonTapped: (() -> Void)?
    var onThirdButtonTapped: (() -> Void)?
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(firstButton)
        containerStackView.addArrangedSubview(secondButton)
        containerStackView.addArrangedSubview(thirdButton)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupActions() {
        firstButton.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(thirdButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func firstButtonTapped() {
        onFirstButtonTapped?()
    }
    
    @objc private func secondButtonTapped() {
        onSecondButtonTapped?()
    }
    
    @objc private func thirdButtonTapped() {
        onThirdButtonTapped?()
    }
    
    // MARK: - Configure
    func configure(with viewModel: FlashSaleViewModel?) {
        // Configure buttons with viewModel data if needed
        firstButton.setTitle(viewModel?.firstButtonTitle ?? "限時搶購", for: .normal)
        secondButton.setTitle(viewModel?.secondButtonTitle ?? "商城優惠", for: .normal)
        thirdButton.setTitle(viewModel?.thirdButtonTitle ?? "品牌特賣", for: .normal)
    }
}
