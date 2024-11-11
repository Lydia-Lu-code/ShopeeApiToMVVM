import UIKit

class BannerCell: UITableViewCell {
    static let reuseIdentifier = "BannerCell"
    
    // MARK: - 屬性
    private var bannerItems: [BannerItem] = []
    private let aspectRatio: CGFloat = 3.4 / 6.4  // 高寬比
    
    // MARK: - UI 元件
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(BannerItemCell.self, forCellWithReuseIdentifier: BannerItemCell.reuseIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .systemRed
        pc.pageIndicatorTintColor = .systemGray4
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.hidesForSinglePage = false
        
        if #available(iOS 14.0, *) {
            pc.backgroundStyle = .minimal
            pc.allowsContinuousInteraction = true
            pc.preferredIndicatorImage = UIImage(systemName: "circle.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 4))
        }
        
        return pc
    }()
    
    
    // MARK: - 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 設定 UI
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        selectionStyle = .none
        
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            // CollectionView 約束
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: aspectRatio),
            
            // PageControl 約束
            pageControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
    }
    
    // MARK: - 公開方法
    func configure(with items: [BannerItem]) {
        bannerItems = items
        pageControl.numberOfPages = items.count
        pageControl.currentPage = 0  // 確保從第一頁開始
        pageControl.isUserInteractionEnabled = true  // 允許用戶點擊切換
        collectionView.reloadData()
    }

    // 在 UICollectionViewDelegate 中添加
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        pageControl.currentPage = page
    }

}

// MARK: - UICollectionView DataSource & Delegate
extension BannerCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerItemCell.reuseIdentifier, for: indexPath) as! BannerItemCell
        cell.configure(with: bannerItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        pageControl.currentPage = page
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = bannerItems[indexPath.item]
        // 處理點擊事件，可以透過代理或閉包通知 ViewController
        print("Banner clicked: \(item.link)")
    }
}
