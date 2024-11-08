//
//  ShopeeAPIService.swift
//  ShopeeApiToMVVM
//
//  Created by Lydia Lu on 2024/11/7.
//

import Foundation

class ShopeeAPIService {
    static let shared = ShopeeAPIService()
    private let baseURL = "https://api.shopee.tw/v2"
    private init() {}
    
    func getProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/products") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
