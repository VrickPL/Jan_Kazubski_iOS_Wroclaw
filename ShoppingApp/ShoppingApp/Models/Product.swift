//
//  Product.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import Foundation

struct Product: Identifiable, Decodable {
    let id: String
    let description: String
    let price: String
    let promotions: [Promotion]
    var isFavorite: Bool
    var inStock: Int
    let imageName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "productId"
        case description
        case price
        case promotions
        case isFavorite
        case inStock
        case imageName = "image"
    }
}

struct Promotion: Decodable {
    let type: String
    let value: String
}

