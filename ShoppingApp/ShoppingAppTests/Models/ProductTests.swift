//
//  ProductTests.swift
//  ShoppingAppTests
//
//  Created by Jan Kazubski on 10/05/2025.
//

import XCTest
@testable import ShoppingApp

final class ProductTests: XCTestCase {
    func testDecodingProductWithoutPromotions() {
        let json = """
            {
                "productId": "123",
                "description": "A test product",
                "price": "19.99 £",
                "promotions": [],
                "isFavorite": false,
                "inStock": 5,
                "image": "test.png"
            }
            """
        
        let decoder = JSONDecoder()
        guard let data = json.data(using: .utf8) else {
            XCTFail("Failed to convert JSON string to Data")
            return
        }
        
        do {
            let product = try decoder.decode(Product.self, from: data)
            XCTAssertEqual(product.id, "123")
            XCTAssertEqual(product.description, "A test product")
            XCTAssertEqual(product.price, "19.99 £")
            XCTAssertTrue(product.promotions.isEmpty)
            XCTAssertEqual(product.isFavorite, false)
            XCTAssertEqual(product.inStock, 5)
            XCTAssertEqual(product.imageName, "test.png")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
    
    func testDecodingProductWithDiscountPromotion() {
        let json = """
            {
                "productId": "456",
                "description": "Discount product",
                "price": "29.99 £",
                "promotions": [
                    { "type": "discount", "value": "5.00 £" }
                ],
                "isFavorite": true,
                "inStock": 10,
                "image": "discount.png"
            }
            """
        
        let decoder = JSONDecoder()
        guard let data = json.data(using: .utf8) else {
            XCTFail("Failed to convert JSON string to Data")
            return
        }
        
        do {
            let product = try decoder.decode(Product.self, from: data)
            XCTAssertEqual(product.id, "456")
            XCTAssertEqual(product.description, "Discount product")
            XCTAssertEqual(product.price, "29.99 £")
            XCTAssertEqual(product.promotions.count, 1)
            XCTAssertEqual(product.promotions.first?.type, PromotionType.discount)
            XCTAssertEqual(product.promotions.first?.value, "5.00 £")
            XCTAssertEqual(product.isFavorite, true)
            XCTAssertEqual(product.inStock, 10)
            XCTAssertEqual(product.imageName, "discount.png")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
    
    func testDecodingProductWithPercentagePromotion() {
        let json = """
            {
                "productId": "789",
                "description": "Percentage product",
                "price": "49.99 £",
                "promotions": [
                    { "type": "percentage", "value": "15%" }
                ],
                "isFavorite": false,
                "inStock": 20,
                "image": "percentage.png"
            }
            """
        
        let decoder = JSONDecoder()
        guard let data = json.data(using: .utf8) else {
            XCTFail("Failed to convert JSON string to Data")
            return
        }
        
        do {
            let product = try decoder.decode(Product.self, from: data)
            XCTAssertEqual(product.id, "789")
            XCTAssertEqual(product.description, "Percentage product")
            XCTAssertEqual(product.price, "49.99 £")
            XCTAssertEqual(product.promotions.count, 1)
            XCTAssertEqual(product.promotions.first?.type, PromotionType.percentage)
            XCTAssertEqual(product.promotions.first?.value, "15%")
            XCTAssertEqual(product.isFavorite, false)
            XCTAssertEqual(product.inStock, 20)
            XCTAssertEqual(product.imageName, "percentage.png")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
    
    func testDecodingProductResponseWithMultipleProducts() {
        let json = """
            {
                "items": [
                    {
                        "productId": "123",
                        "description": "Product one",
                        "price": "10.00 £",
                        "promotions": [],
                        "isFavorite": false,
                        "inStock": 5,
                        "image": "one.png"
                    },
                    {
                        "productId": "456",
                        "description": "Product two",
                        "price": "20.00 £",
                        "promotions": [
                            { "type": "discount", "value": "2.00 £" }
                        ],
                        "isFavorite": true,
                        "inStock": 8,
                        "image": "two.png"
                    },
                    {
                        "productId": "789",
                        "description": "Product three",
                        "price": "30.00 £",
                        "promotions": [
                            { "type": "percentage", "value": "10%" }
                        ],
                        "isFavorite": false,
                        "inStock": 12,
                        "image": "three.png"
                    }
                ]
            }
            """
        
        let decoder = JSONDecoder()
        guard let data = json.data(using: .utf8) else {
            XCTFail("Failed to convert JSON string to Data")
            return
        }
        
        do {
            let response = try decoder.decode(ProductResponse.self, from: data)
            XCTAssertEqual(response.items.count, 3)
            
            let product1 = response.items[0]
            XCTAssertEqual(product1.id, "123")
            XCTAssertEqual(product1.description, "Product one")
            XCTAssertEqual(product1.price, "10.00 £")
            XCTAssertTrue(product1.promotions.isEmpty)
            XCTAssertEqual(product1.isFavorite, false)
            XCTAssertEqual(product1.inStock, 5)
            XCTAssertEqual(product1.imageName, "one.png")
            
            let product2 = response.items[1]
            XCTAssertEqual(product2.id, "456")
            XCTAssertEqual(product2.description, "Product two")
            XCTAssertEqual(product2.price, "20.00 £")
            XCTAssertEqual(product2.promotions.count, 1)
            XCTAssertEqual(product2.promotions.first?.type, PromotionType.discount)
            XCTAssertEqual(product2.promotions.first?.value, "2.00 £")
            XCTAssertEqual(product2.isFavorite, true)
            XCTAssertEqual(product2.inStock, 8)
            XCTAssertEqual(product2.imageName, "two.png")
            
            let product3 = response.items[2]
            XCTAssertEqual(product3.id, "789")
            XCTAssertEqual(product3.description, "Product three")
            XCTAssertEqual(product3.price, "30.00 £")
            XCTAssertEqual(product3.promotions.count, 1)
            XCTAssertEqual(product3.promotions.first?.type, PromotionType.percentage)
            XCTAssertEqual(product3.promotions.first?.value, "10%")
            XCTAssertEqual(product3.isFavorite, false)
            XCTAssertEqual(product3.inStock, 12)
            XCTAssertEqual(product3.imageName, "three.png")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
    
    func testRawValueForDiscount() {
        XCTAssertEqual(PromotionType.discount.rawValue, "discount")
    }
    
    func testRawValueForPercentage() {
        XCTAssertEqual(PromotionType.percentage.rawValue, "percentage")
    }
    
    func testEnumExhaustiveness() {
        XCTAssertEqual(PromotionType.allCases, [PromotionType.discount, PromotionType.percentage])
    }
}
