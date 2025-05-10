//
//  CheckoutView.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 10/05/2025.
//

import SwiftUI
import SwiftData

struct CheckoutView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<ProductEntity> { product in
        product.quantityInCart > 0
    }, sort: \.productDescription) private var storedProducts: [ProductEntity]


    var body: some View {
        NavigationView {
            VStack {
                ProductList(products: storedProducts)
                
                if !storedProducts.isEmpty {
                    checkoutButton
                }
            }
            .navigationTitle("Checkout")
        }
    }
    
    var checkoutButton: some View {
        Button {
            // TODO: show alert
        } label: {
            HStack {
                Spacer()
                Text("Checkout")
                    .foregroundStyle(.black)
                Spacer()
            }
            .padding(12)
            .background(Color.yellow)
            .cornerRadius(10)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
}

#Preview {
    CheckoutView()
}
