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
    
    @State private var isShowingAlert = false
    
    private var basketValue: String {
        BasketCalculator.calculateTotalValue(for: storedProducts)
    }
    
    private var basketProductIDs: String {
        storedProducts
            .map { "\($0.id)" }
            .joined(separator: ", ")
    }

    var body: some View {
        NavigationStack {
            VStack {
                ProductList(products: storedProducts)
                
                if !storedProducts.isEmpty {
                    checkoutButton
                }
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text(basketValue)
                        .fontWeight(.bold)
                        .accessibilityLabel("Total basket value")
                        .accessibilityValue(basketValue)
                }
            }
            .alert("Basket Items", isPresented: $isShowingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(basketProductIDs)
            }
        }
    }
    
    private var checkoutButton: some View {
        Button {
            isShowingAlert = true
        } label: {
            HStack {
                Spacer()
                Text("Checkout")
                    .foregroundStyle(.black)
                    .accessibilityLabel("Checkout button")
                    .accessibilityHint("Tap to view the items in your basket.")
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
