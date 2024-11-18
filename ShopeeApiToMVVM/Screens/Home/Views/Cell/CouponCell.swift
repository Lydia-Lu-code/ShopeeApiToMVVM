import UIKit

class CouponCell: UITableViewCell {
    static let reuseIdentifier = "CouponCell"
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        // 設定只有底部邊線
        button.layer.borderWidth = 1
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return button
    }()
    
    private let couponButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Callback
    var onCouponButtonTapped: (() -> Void)?
    
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
//        contentView.backgroundColor = .clear
        containerView.backgroundColor = .white      // 或您想要的顏色
        
        contentView.addSubview(containerView)
        containerView.addSubview(topButton)
        containerView.addSubview(couponButton)
        
        NSLayoutConstraint.activate([
            // 容器視圖的約束
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // 頂部按鈕的約束 (高度為整體的1/4)
            topButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            topButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            topButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.25),
            
            // 優惠券按鈕的約束 (上下邊界10，左右邊界18)
            couponButton.topAnchor.constraint(equalTo: topButton.bottomAnchor, constant: 45),
            couponButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 35),
            couponButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -35),
            couponButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -25)
        ])
    }
    
    private func setupActions() {
        couponButton.addTarget(self, action: #selector(couponButtonTapped), for: .touchUpInside)
        topButton.addTarget(self, action: #selector(couponButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func couponButtonTapped() {
        onCouponButtonTapped?()
    }
    
    func configure(with viewModel: CouponViewModel) {
        topButton.setTitle(viewModel.topButtonTitle, for: .normal)
        topButton.backgroundColor = viewModel.backgroundColor
        
        couponButton.setTitle(viewModel.couponButtonTitle, for: .normal)
        couponButton.backgroundColor = viewModel.backgroundColor
    }

}

