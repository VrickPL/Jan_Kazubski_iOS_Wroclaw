//
//  BrowseViewModelTests.swift
//  ShoppingAppTests
//
//  Created by Jan Kazubski on 10/05/2025.
//

import XCTest
@testable import ShoppingApp

final class BrowseViewModelTests: XCTestCase {
    let fileName = "tempItem"
    let fileExtension = "json"
    
    private func fullFileName() -> String {
        return "\(fileName)_\(UUID().uuidString).\(fileExtension)"
    }
    
    private func writeTemporaryFile(with content: String) -> URL {
        let tempDir = NSTemporaryDirectory()
        let name = fullFileName()
        let fileURL = URL(fileURLWithPath: tempDir).appendingPathComponent(name)
        try? content.write(to: fileURL, atomically: true, encoding: .utf8)
        return fileURL
    }
    
    private func removeTemporaryFile(at url: URL) {
        try? FileManager.default.removeItem(at: url)
    }
    
    func testBasic() {
        let viewModel = BrowseViewModel()
        
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testLoadProductsSuccess1() {
        let validJSON = """
            {
                "items": [
                    {
                        "productId": "123",
                        "description": "Test product",
                        "price": "10.00 £",
                        "promotions": [],
                        "isFavorite": false,
                        "inStock": 5,
                        "image": "image.png"
                    }
                ]
            }
            """
        let tempURL = writeTemporaryFile(with: validJSON)
        let viewModel = BrowseViewModel()
        viewModel.loadProducts(forResource: fileName, fileURL: tempURL)
        
        let expectation = self.expectation(description: "loadProducts completes")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
        
        removeTemporaryFile(at: tempURL)
    }
    
    func testLoadProductsSuccess2() {
        let validJSON = """
            {
                "items": [
                    {
                        "productId": "123",
                        "description": "Test product",
                        "price": "20.00 £",
                        "promotions": [],
                        "isFavorite": true,
                        "inStock": 10,
                        "image": "image.png"
                    }
                ]
            }
            """
        let tempURL = writeTemporaryFile(with: validJSON)
        let viewModel = BrowseViewModel()
        let product = ProductEntity(
            id: "123",
            productDescription: "Test product",
            price: "10.00 £",
            promotions: [],
            isFavorite: false,
            inStock: 10,
            imageName: "image.png",
            quantityInCart: 0
        )
        viewModel.products = [product, product, product]
        viewModel.error = ProductListError.missingFile
        
        viewModel.loadProducts(forResource: fileName, fileURL: tempURL)
        
        let expectation = self.expectation(description: "loadProducts completes")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
        
        removeTemporaryFile(at: tempURL)
    }
    
    func testLoadProductsMissingFile() {
        let viewModel = BrowseViewModel()
        viewModel.loadProducts(forResource: fileName)

        let expectation = self.expectation(description: "loadProducts completes")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertTrue(viewModel.error is ProductListError)
        XCTAssertEqual(viewModel.error as! ProductListError, ProductListError.missingFile)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testLoadProductsDecodingError() {
        let invalidJSON = "invalid json"
        let tempURL = writeTemporaryFile(with: invalidJSON)
        let viewModel = BrowseViewModel()
        viewModel.loadProducts(fileURL: tempURL)
        
        let expectation = self.expectation(description: "loadProducts completes")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(viewModel.error is DecodingError)
        XCTAssertFalse(viewModel.isLoading)
        
        removeTemporaryFile(at: tempURL)
    }
    
    func testEnumExhaustiveness() {
        XCTAssertEqual(ProductListError.allCases, [ProductListError.missingFile])
    }
    
    func testMissingFileError() {
        XCTAssertNotNil(ProductListError.missingFile.errorDescription)
    }
}
