//
//  ProductEntity.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 10/05/2025.
//

import Foundation
import SwiftData

@Model
final class ProductEntity {
    var id: String
    var productDescription: String
    var price: String
    var promotions: [PromotionEntity]
    var isFavorite: Bool
    var inStock: Int
    var imageName: String
    
    var quantityInCart: Int

    init(
        id: String,
        productDescription: String,
        price: String,
        promotions: [PromotionEntity],
        isFavorite: Bool,
        inStock: Int,
        imageName: String,
        quantityInCart: Int = 0
    ) {
        self.id = id
        self.productDescription = productDescription
        self.price = price
        self.promotions = promotions
        self.isFavorite = isFavorite
        self.inStock = inStock
        self.imageName = imageName
        self.quantityInCart = quantityInCart
    }
}

@Model
final class PromotionEntity {
    var type: String
    var value: String

    init(type: String, value: String) {
        self.type = type
        self.value = value
    }
}


extension ProductEntity {
    convenience init(from product: Product) {
        self.init(
            id: product.id,
            productDescription: product.description,
            price: product.price,
            promotions: product.promotions.map { PromotionEntity(type: $0.type.rawValue, value: $0.value) },
            isFavorite: product.isFavorite,
            inStock: product.inStock,
            imageName: product.imageName,
            quantityInCart: 0
        )
    }
}
