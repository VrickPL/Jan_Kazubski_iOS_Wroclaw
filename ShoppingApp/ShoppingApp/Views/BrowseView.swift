//
//  BrowseView.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import SwiftUI
import SwiftData

struct BrowseView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ProductEntity.productDescription) private var storedProducts: [ProductEntity]
    
    @StateObject private var viewModel = BrowseViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                            .padding()
                        Spacer()
                    }
                } else if let error = viewModel.error {
                    ErrorView(error: error, onRetry: viewModel.refreshProducts)
                } else {
                    ProductList(products: storedProducts)
                }
            }
            .navigationTitle("Browse")
        }
        .onAppear {
            storeProductsIfNeeded()
        }
    }
    
    private func storeProductsIfNeeded() {
        if storedProducts.isEmpty {
            viewModel.loadProducts()
            
            for product in viewModel.products {
                modelContext.insert(product)
            }

            try? modelContext.save()
        }
    }
}

#Preview {
    BrowseView()
}
