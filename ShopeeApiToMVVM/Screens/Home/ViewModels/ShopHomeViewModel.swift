import Foundation

class ShopHomeViewModel: BaseNavigationViewModel {
    
    enum Section: Int, CaseIterable {
        case banner
        case category
        case flashSale
        case coupon
        
        
    }
    
    // MARK: - 屬性
    private var products: [Product] = []
    private var banners: [BannerItem] = []
    private(set) var categoryViewModel: CategoryViewModel
    private(set) var flashSaleViewModel: FlashSaleViewModel
    private(set) var couponViewModel: CouponViewModel
    
    override init() {
        let categoryItems: [[CategoryItem]] = [
            [
                CategoryItem(emoji: "🛍️", title: "每日特賣"),
                CategoryItem(emoji: "🎮", title: "遊戲"),
                CategoryItem(emoji: "👕", title: "服飾"),
                CategoryItem(emoji: "📱", title: "手機"),
                CategoryItem(emoji: "💄", title: "美妝")
            ],
            [
                CategoryItem(emoji: "🏠", title: "居家"),
                CategoryItem(emoji: "📚", title: "書籍"),
                CategoryItem(emoji: "🎵", title: "音樂"),
                CategoryItem(emoji: "🖥️", title: "電腦"),
                CategoryItem(emoji: "🎁", title: "禮品")
            ]
        ]
        
        self.categoryViewModel = CategoryViewModel(categories: categoryItems)
        self.flashSaleViewModel = FlashSaleViewModel(
            firstButtonTitle: "限時搶購",
            secondButtonTitle: "商城優惠",
            thirdButtonTitle: "品牌特賣"
        )
        self.couponViewModel = CouponViewModel(
            title: "領取折價券",
            backgroundColor: .systemPink
        )
        super.init()  // 加上這行，呼叫父類別的初始化方法
        setupMockData()
    }
    
    var onDataUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    
    // MARK: - 公開方法
    var bannerItems: [BannerItem] {
        return banners
    }
    
    func numberOfSections() -> Int {
        return Section.allCases.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .banner, .flashSale, .category, .coupon:
            return 1
        }
    }
    
    func product(at index: Int) -> Product {
        return products[index]
    }
    
    // 將 fetchProducts 改為公開方法
    func fetchProducts() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.onDataUpdate?()
        }
    }
    
    func fetchData() {
        fetchProducts()
    }
    
    private func setupMockData() {
        banners = (1...13).map { index in
            BannerItem(
                id: index,
                imageUrl: "https://picsum.photos/640/340?random=\(index)",
                link: "https://example.com/promo\(index)",
                title: "Banner \(index)"
            )
        }
        
        products = []
    }
    
    
}

