//
//  CouponCell.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/12.
//

import UIKit

class CouponCell: UITableViewCell {
    static let reuseIdentifier = "CouponCell"
    
    // MARK: - UI Components
    private let couponButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("領取折價券", for: .normal)
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
        contentView.backgroundColor = .clear
        
        contentView.addSubview(couponButton)
        
        NSLayoutConstraint.activate([
            couponButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            couponButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            couponButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            couponButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupActions() {
        couponButton.addTarget(self, action: #selector(couponButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func couponButtonTapped() {
        onCouponButtonTapped?()
    }
    
    // MARK: - Configure
    func configure(with viewModel: CouponViewModel) {
        couponButton.setTitle(viewModel.title, for: .normal)
        couponButton.backgroundColor = viewModel.backgroundColor
    }
}
