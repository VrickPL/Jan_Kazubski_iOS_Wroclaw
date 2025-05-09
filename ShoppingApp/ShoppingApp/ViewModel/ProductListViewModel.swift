//
//  ProductListViewModel.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import Foundation

final class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var error: Error? = nil
    @Published var isLoading = false
    
    func loadProductsIfNeeded() {
        if !products.isEmpty { return }

        loadProducts()
    }
    
    func refreshProducts() {
        self.products = []
        self.error = nil
        loadProducts()
    }
    
    private func loadProducts() {
        guard !isLoading else { return }
        self.isLoading = true

        guard let url = Bundle.main.url(forResource: "items", withExtension: "json") else {
            self.error = ProductListError.missingFile
            self.isLoading = false
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(ProductResponse.self, from: data)
            
            DispatchQueue.main.async {
                self.products = response.items
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.error = error
                self.isLoading = false
            }
        }
    }
}

enum ProductListError: LocalizedError {
    case missingFile
    
    var errorDescription: String? {
        switch self {
        case .missingFile:
            return "The 'items.json' file was not found."
        }
    }
}
