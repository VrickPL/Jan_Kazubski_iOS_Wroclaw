//
//  ProductViewTests.swift
//  ShoppingAppTests
//
//  Created by Jan Kazubski on 10/05/2025.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import ShoppingApp

final class ProductViewTests: XCTestCase {
    private let testProduct = ProductEntity(
        id: "123",
        productDescription: "Test product",
        price: "22.50 £",
        promotions: [],
        isFavorite: false,
        inStock: 10,
        imageName: "image.png"
    )
    
    private let testProductWithDiscountPromotion = ProductEntity(
        id: "123",
        productDescription: "Test product",
        price: "22.50 £",
        promotions: [PromotionEntity(type: "discount", value: "5.00 £")],
        isFavorite: false,
        inStock: 10,
        imageName: "image.png"
    )
    
    private let testProductWithPercentagePromotion = ProductEntity(
        id: "123",
        productDescription: "Test product",
        price: "22.50 £",
        promotions: [PromotionEntity(type: "percentage", value: "10%")],
        isFavorite: false,
        inStock: 10,
        imageName: "image.png"
    )
    
    func testProductDescriptionIsDisplayed() throws {
        let view = ProductView(product: testProduct)
        let inspectedView = try view.inspect()
        
        let descriptionText = try inspectedView.find(ViewType.Text.self, where: { text in
            (try? text.accessibilityLabel().string()) == "Product"
        }).string()
        
        XCTAssertEqual(descriptionText, "Test product")
    }
    
    func testPriceDisplayedWithoutPromotion() throws {
        let view = ProductView(product: testProduct)
        let inspectedView = try view.inspect()
        
        let priceText = try inspectedView.find(ViewType.Text.self, where: { text in
            (try? text.accessibilityLabel().string()) == "Price"
        }).string()
        
        XCTAssertEqual(priceText, "22.50 £")
    }
    
    func testQuantityControlsInitialDisplay() throws {
        let view = ProductView(product: testProduct)
        let inspectedView = try view.inspect()
        
        let quantityText = try inspectedView.find(ViewType.Text.self, where: { text in
            (try? text.accessibilityLabel().string()) == "Quantity"
        }).string()
        
        XCTAssertEqual(quantityText, "0")
    }
    
    func testIncreaseQuantityButton() throws {
        let view = ProductView(product: testProduct)
        let inspectedView = try view.inspect()
        
        let increaseButton = try inspectedView.find(ViewType.Button.self, where: { button in
            (try? button.accessibilityLabel().string()) == "Increase quantity"
        })
        try increaseButton.tap()
        
        XCTAssertEqual(testProduct.quantityInCart, 1)
    }
    
    func testDecreaseQuantityButton() throws {
        let product = testProduct
        product.quantityInCart = 2
        let view = ProductView(product: product)
        let inspectedView = try view.inspect()
        
        let decreaseButton = try inspectedView.find(ViewType.Button.self, where: { button in
            (try? button.accessibilityLabel().string()) == "Decrease quantity"
        })
        try decreaseButton.tap()
        
        XCTAssertEqual(testProduct.quantityInCart, 1)
    }
    
    func testFavoriteToggleButton() throws {
        let view = ProductView(product: testProduct)
        let inspectedView = try view.inspect()
        
        let favoriteButtonInitial = try inspectedView.find(ViewType.Button.self, where: { button in
            (try? button.accessibilityLabel().string()) == "Add to favorites"
        })
        try favoriteButtonInitial.tap()
        XCTAssertTrue(testProduct.isFavorite)
        
        let favoriteButtonUpdated = try inspectedView.find(ViewType.Button.self, where: { button in
            (try? button.accessibilityLabel().string()) == "Remove from favorites"
        })
        try favoriteButtonUpdated.tap()
        XCTAssertFalse(testProduct.isFavorite)
    }
    
    func testPromotionDiscountDisplayed() throws {
        let view = ProductView(product: testProductWithDiscountPromotion)
        let inspectedView = try view.inspect()
        
        let discountedPriceText = try inspectedView.find(ViewType.Text.self, where: { text in
            (try? text.accessibilityLabel().string()) == "Discounted price"
        }).string()
        XCTAssertEqual(discountedPriceText, "5.00 £")
        
        let originalPriceText = try inspectedView.find(ViewType.Text.self, where: { text in
            (try? text.accessibilityLabel().string()) == "Original price"
        }).string()
        XCTAssertEqual(originalPriceText, "22.50 £")
    }
    
    func testPromotionPercentageDisplayed() throws {
        let view = ProductView(product: testProductWithPercentagePromotion)
        let inspectedView = try view.inspect()
        
        let originalPriceText = try inspectedView.find(ViewType.Text.self, where: { text in
            (try? text.accessibilityLabel().string()) == "Original price"
        }).string()
        XCTAssertEqual(originalPriceText, "22.50 £")
        
        let discountedPriceText = try inspectedView.find(ViewType.Text.self, where: { text in
            (try? text.accessibilityLabel().string()) == "Discount"
        }).string()
        XCTAssertEqual(discountedPriceText, "-10%")
    }
}
