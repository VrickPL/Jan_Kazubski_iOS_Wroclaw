//
//  BasketCalculator.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 10/05/2025.
//

import Foundation

struct BasketCalculator {
    static func calculateTotalValue(for products: [ProductEntity]) -> String {
        let total = products.reduce(0) { $0 + ($1.discountedPrice * Double($1.quantityInCart)) }
        return String(format: "%.2f £", total)
    }
}
