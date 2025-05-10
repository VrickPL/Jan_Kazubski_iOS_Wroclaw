//
//  BrowseViewTests.swift
//  ShoppingAppTests
//
//  Created by Jan Kazubski on 10/05/2025.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import ShoppingApp

final class BrowseViewTests: XCTestCase {
    func testLoadingStateDisplaysProgressView() throws {
        let mockVM = MockBrowseViewModel()
        mockVM.isLoading = true
        let view = BrowseView(viewModel: mockVM)
        let inspectedView = try view.inspect()
        
        let progressView = try inspectedView
            .navigationView()
            .group(0)
            .vStack(0)
            .find(ViewType.ProgressView.self) { view in
                let label = try? view.accessibilityLabel().string()
                return label == "Loading products"
            }
        XCTAssertNotNil(progressView)
    }
    
    func testErrorStateDisplaysErrorView() throws {
        let mockVM = MockBrowseViewModel()
        let sampleError = NSError(domain: "TestDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error message"])
        mockVM.error = sampleError
        mockVM.isLoading = false
        
        let view = BrowseView(viewModel: mockVM)
        let inspectedView = try view.inspect()
        
        let errorView = try inspectedView
            .navigationView()
            .group(0)
            .find(ErrorView.self)
        let errorDetail = try errorView.vStack().text(1).string()
        XCTAssertEqual(errorDetail, "Test error message")
    }
    
    func testProductListStateDisplaysEmptyMessage() throws {
        let mockVM = MockBrowseViewModel()
        mockVM.isLoading = false
        mockVM.error = nil
        let view = BrowseView(viewModel: mockVM)
        let inspectedView = try view.inspect()
        
        let emptyText = try inspectedView
            .navigationView()
            .group(0)
            .find(ViewType.Text.self) { text in
                let label = try? text.accessibilityLabel().string()
                return label == "Empty product list"
            }
        let textString = try emptyText.string()
        XCTAssertEqual(textString, "The product list is empty.")
    }
    
    private final class MockBrowseViewModel: BrowseViewModel {
        var mockProducts: [ProductEntity] = []
        
        override func loadProducts(forResource resource: String = "items", fileURL: URL? = nil) {}
        
        override func refreshProducts() {}
    }
}
