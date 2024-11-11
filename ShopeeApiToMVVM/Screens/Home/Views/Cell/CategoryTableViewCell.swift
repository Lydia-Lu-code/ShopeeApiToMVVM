//
//  CategoryTableViewCell.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/11.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CategoryTableViewCell"
    private var viewModel: CategoryViewModel?

    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private var categories: [[CategoryItem]] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.self,
                              forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with categories: [[CategoryItem]]) {
        self.categories = categories
        collectionView.reloadData()
    }
    
    func configure(with viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }

    
}

// MARK: - UICollectionView DataSource & Delegate
extension CategoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as! CategoryCollectionViewCell
        
        if let item = viewModel?.item(at: indexPath) {
            cell.configure(with: item)
        }
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.width
        let spacing: CGFloat = 10
        let itemWidth = (totalWidth - spacing * 4) / 5 // 5個項目，4個間距
        return CGSize(width: itemWidth, height: 60) // 高度包含emoji和文字
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
