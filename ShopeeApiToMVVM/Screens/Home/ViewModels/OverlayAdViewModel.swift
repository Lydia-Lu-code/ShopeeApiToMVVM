
import UIKit

class OverlayAdViewModel {
    // 廣告內容模型
    struct AdContent {
        let imageUrl: String
        let targetUrl: String
    }
    
    private let adContent: AdContent
    let initialDelay: TimeInterval // 初始延遲時間
    let repeatDelay: TimeInterval  // 重複延遲時間
    var isVisible: Bool = false
    private var timer: Timer?      // 用於重複顯示
    
    // 回調事件
    var onAdTapped: (() -> Void)?
    var onCloseButtonTapped: (() -> Void)?
    var onAdDisplayed: (() -> Void)?
    
    init(adContent: AdContent,
         initialDelay: TimeInterval = 5.0,
         repeatDelay: TimeInterval = 15.0) {
        self.adContent = adContent
        self.initialDelay = initialDelay
        self.repeatDelay = repeatDelay
    }
    
    func getAdImageUrl() -> String {
        return adContent.imageUrl
    }
    
    func handleAdTapped() {
        onAdTapped?()
    }
    
    func handleCloseButtonTapped() {
        isVisible = false
        onCloseButtonTapped?()
        startRepeatTimer()  // 開始重複計時
    }
    
    func startDisplayTimer() {
        // 首次顯示
        DispatchQueue.main.asyncAfter(deadline: .now() + initialDelay) { [weak self] in
            self?.showAd()
        }
    }
    
    private func startRepeatTimer() {
        // 取消現有的計時器
        timer?.invalidate()
        
        // 設定新的計時器
        timer = Timer.scheduledTimer(withTimeInterval: repeatDelay, repeats: false) { [weak self] _ in
            self?.showAd()
        }
    }
    
    private func showAd() {
        isVisible = true
        onAdDisplayed?()
    }
    
    // 清理方法
    func cleanup() {
        timer?.invalidate()
        timer = nil
    }
}

////
////  OverlayAdView.swift
////  ShopeeApiToMVVM
////
////  Created by Lydia Lu on 2024/11/15.
////
//
//import UIKit
//
//class OverlayAdViewModel {
//    // 廣告內容模型
//    struct AdContent {
//        let imageUrl: String
//        let targetUrl: String
//    }
//    
//    private let adContent: AdContent
//    let displayDelay: TimeInterval
//    var isVisible: Bool = false
//    
//    // 回調事件
//    var onAdTapped: (() -> Void)?
//    var onCloseButtonTapped: (() -> Void)?
//    var onAdDisplayed: (() -> Void)?
//    
//    init(adContent: AdContent, displayDelay: TimeInterval = 5.0) {
//        self.adContent = adContent
//        self.displayDelay = displayDelay
//    }
//    
//    func getAdImageUrl() -> String {
//        return adContent.imageUrl
//    }
//    
//    func handleAdTapped() {
//        // 處理廣告點擊，例如打開網頁
//        onAdTapped?()
//    }
//    
//    func handleCloseButtonTapped() {
//        isVisible = false
//        onCloseButtonTapped?()
//    }
//    
//    func startDisplayTimer() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + displayDelay) { [weak self] in
//            self?.isVisible = true
//            self?.onAdDisplayed?()
//        }
//    }
//}
