//
//  BrowseViewModel.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import Foundation

final class BrowseViewModel: ObservableObject {
    @Published var products: [ProductEntity] = []
    @Published var error: Error? = nil
    @Published var isLoading = false
    
    func refreshProducts() {
        self.products = []
        self.error = nil
        loadProducts()
    }
    
    func loadProducts() {
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
            
            let entities = response.items.map { ProductEntity(from: $0) }
            self.products = entities
            self.isLoading = false
        } catch {
            self.error = error
            self.isLoading = false
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
