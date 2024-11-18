//
//  BrandSaleCell.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/13.
//

import UIKit

class BrandSaleCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "BrandSaleCell"
    var onBrandButtonTapped: (() -> Void)?
    var onImageTapped: ((Int) -> Void)?
    var onMoreButtonTapped: (() -> Void)?
    
    // MARK: - UI Components
    private let buttonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemTeal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let brandButton: UIButton = {
        let button = UIButton()
        button.setTitle("品牌特殺", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBrown
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let middleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "天天搶優惠券！"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("查看更多", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        selectionStyle = .none
        
        // 新增視圖
        contentView.addSubview(buttonContainerView)
        buttonContainerView.addSubview(brandButton)
        
        // 添加中間容器視圖
        contentView.addSubview(middleContainerView)
        middleContainerView.addSubview(infoLabel)
        middleContainerView.addSubview(moreButton)
        
        contentView.addSubview(scrollContainerView)
        scrollContainerView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        // 添加六張圖片
        for i in 0..<6 {
            let imageView = createImageView(index: i)
            stackView.addArrangedSubview(imageView)
        }
        
        // 設定約束
        NSLayoutConstraint.activate([
            // 按鈕容器視圖
            buttonContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            buttonContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buttonContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            buttonContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
           
            // 按鈕
            brandButton.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor),
            brandButton.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor),
            brandButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor),
            brandButton.bottomAnchor.constraint(equalTo: buttonContainerView.bottomAnchor),
            
            // 中間容器視圖
                    middleContainerView.topAnchor.constraint(equalTo: buttonContainerView.bottomAnchor),
                    middleContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    middleContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    middleContainerView.heightAnchor.constraint(equalTo: buttonContainerView.heightAnchor),
                    
                    // 資訊標籤
                    infoLabel.leadingAnchor.constraint(equalTo: middleContainerView.leadingAnchor, constant: 16),
                    infoLabel.centerYAnchor.constraint(equalTo: middleContainerView.centerYAnchor),
                    
                    // 更多按鈕
                    moreButton.trailingAnchor.constraint(equalTo: middleContainerView.trailingAnchor, constant: -16),
                    moreButton.centerYAnchor.constraint(equalTo: middleContainerView.centerYAnchor),
                    
                    // 滾動容器視圖 (修改 topAnchor)
                    scrollContainerView.topAnchor.constraint(equalTo: middleContainerView.bottomAnchor),
                    scrollContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    scrollContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    scrollContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    
            
//            // 滾動容器視圖
//            scrollContainerView.topAnchor.constraint(equalTo: buttonContainerView.bottomAnchor),
//            scrollContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            scrollContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            scrollContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // 滾動視圖
            scrollView.topAnchor.constraint(equalTo: scrollContainerView.topAnchor, constant: 5),
            scrollView.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: scrollContainerView.bottomAnchor, constant: -20),
            
            // 堆疊視圖
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: -30)
        ])
        
        brandButton.addTarget(self, action: #selector(brandButtonTapped), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    @objc private func brandButtonTapped() {
        onBrandButtonTapped?()
    }
    
    @objc private func moreButtonTapped() {
        onMoreButtonTapped?()
    }
    
    private func updateImageViews(with images: [BrandImageItem]) {
        // 清除現有的圖片
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 添加新的圖片
        for (index, imageItem) in images.enumerated() {
            let imageView = createImageView(index: index)
            // 這裡可以使用 SDWebImage 或其他圖片載入框架
            imageView.backgroundColor = .systemGray5 // 暫時用背景色代替
            stackView.addArrangedSubview(imageView)
            
            // 添加點擊事件
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            imageView.tag = index
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
        }
    }
    
    @objc private func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view else { return }
        onImageTapped?(imageView.tag)
    }
    
    // MARK: - Configuration
    func configure(with viewModel: BrandSaleViewModel) {
        brandButton.setTitle(viewModel.title, for: .normal)
        updateImageViews(with: viewModel.brandImages)
        onBrandButtonTapped = viewModel.onBrandButtonTapped
        onImageTapped = viewModel.onImageTapped
    }
    
    private func createImageView(index: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // 設定固定大小
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 110),
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        return imageView
    }
}
