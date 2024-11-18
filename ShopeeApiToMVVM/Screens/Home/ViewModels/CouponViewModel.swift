//
//  CouponViewModel.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/12.
//

import Foundation
import UIKit

//struct CouponViewModel {
//    let title: String
//    let backgroundColor: UIColor
//}


class CouponViewModel {
    let topButtonTitle: String
    let couponButtonTitle: String
    let backgroundColor: UIColor
    
    init(topButtonTitle: String, couponButtonTitle: String, backgroundColor: UIColor) {
        self.topButtonTitle = topButtonTitle
        self.couponButtonTitle = couponButtonTitle
        self.backgroundColor = backgroundColor
    }
}
