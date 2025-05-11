//
//  ProductList.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import SwiftUI

struct ProductList: View {
    var products: [ProductEntity]
    
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 400), spacing: 16)
    ]
    
    var body: some View {
        if products.isEmpty {
            Text("The product list is empty.")
                .font(.headline)
                .padding()
                .accessibilityLabel("Empty product list")
                .accessibilityHint("There are no products to display.")
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(products) { product in
                        ProductView(product: product)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ProductList(products: [])
}
