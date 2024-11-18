//
//  OverlayAdView.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/15.
//

import UIKit

class OverlayAdView: UIView {
    // MARK: - Properties
    private var viewModel: OverlayAdViewModel?
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 15 // 直徑30的一半
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        addSubview(backgroundView)
        addSubview(containerView)
        containerView.addSubview(adImageView)
        addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            // 背景視圖
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // 廣告容器
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1.2),
            
            // 廣告圖片
            adImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            adImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            adImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            adImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            // 關閉按鈕
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -15),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 15),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        isHidden = true
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(adTapped))
        adImageView.addGestureRecognizer(tap)
    }
    
    // MARK: - Actions
    @objc private func closeButtonTapped() {
        viewModel?.handleCloseButtonTapped()
    }
    
    @objc private func adTapped() {
        viewModel?.handleAdTapped()
    }
    
    // MARK: - Configuration
    func configure(with viewModel: OverlayAdViewModel) {
        self.viewModel = viewModel
        
        // 設定圖片
        // 這裡可以使用 SDWebImage 或其他圖片加載框架
        // adImageView.sd_setImage(with: URL(string: viewModel.getAdImageUrl()))
        
        viewModel.onCloseButtonTapped = { [weak self] in
            self?.isHidden = true
        }
        
        viewModel.onAdDisplayed = { [weak self] in
            self?.isHidden = false
        }
        
        // 開始計時
        viewModel.startDisplayTimer()
    }
    
    // MARK: - Cleanup
    func cleanup() {
        viewModel?.cleanup()
    }
    
    deinit {
        cleanup()
    }
}
