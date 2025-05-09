//
//  ProductList.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import SwiftUI

struct ProductList: View {
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
                } else if viewModel.products.isEmpty {
                    //TODO: show info
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.products) { product in
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
            viewModel.loadProductsIfNeeded()
        }
    }
}

#Preview {
    ProductList()
}
