//
//  ProductList.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import SwiftUI

struct ProductList: View {
    var products: [ProductEntity]
    
    var body: some View {
        if products.isEmpty {
            Text("The product list is empty.")
                .font(.headline)
                .padding()
        } else {
            ScrollView {
                LazyVStack(spacing: 16) {
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
