//
//  CategoryCollectionViewCell.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/11.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CategoryCollectionViewCell"
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(emojiLabel)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            // emoji 標籤置中
            emojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            emojiLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            emojiLabel.heightAnchor.constraint(equalTo: emojiLabel.widthAnchor), // 保持正方形
            
            // 文字標籤
            titleLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    func configure(with item: CategoryItem) {
        emojiLabel.text = item.emoji
        titleLabel.text = item.title
    }
}
