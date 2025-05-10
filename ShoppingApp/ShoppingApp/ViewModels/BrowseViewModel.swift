//
//  BrowseViewModel.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import Foundation

class BrowseViewModel: ObservableObject {
    @Published var products: [ProductEntity] = []
    @Published var error: Error? = nil
    @Published var isLoading = false
    
    private var fileLoader: (String, String) throws -> Data = { resource, fileExtension in
        guard let url = Bundle.main.url(forResource: resource, withExtension: fileExtension) else {
            throw ProductListError.missingFile
        }
        return try Data(contentsOf: url)
    }
    
    func refreshProducts() {
        loadProducts()
    }
    
    func loadProducts(forResource resource: String = "items", fileURL: URL? = nil) {
        self.isLoading = true
        
        do {
            let data: Data
            if let url = fileURL {
                data = try Data(contentsOf: url)
            } else {
                data = try fileLoader(resource, "json")
            }
            let response = try JSONDecoder().decode(ProductResponse.self, from: data)
            
            self.products = response.items.map { ProductEntity(from: $0) }
            self.error = nil
        } catch {
            self.error = error
        }
        
        self.isLoading = false
    }
}

enum ProductListError: LocalizedError, CaseIterable {
    case missingFile
    
    var errorDescription: String? {
        switch self {
        case .missingFile:
            return "The 'items.json' file was not found."
        }
    }
}
