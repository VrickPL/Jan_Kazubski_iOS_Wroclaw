//
//  ProductList.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import SwiftUI
import SwiftData

struct ProductList: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ProductEntity.productDescription) private var storedProducts: [ProductEntity]
    
    @StateObject private var viewModel = ProductListViewModel()
    
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
                } else if storedProducts.isEmpty {
                    //TODO: show info
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(storedProducts) { product in
                                ProductView(product: product)
                            }
                        }
                        .padding()
                    }
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
    ProductList()
}
