//
//  NetworkError.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/8.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
}
