//
//  BasketCalculatorTests.swift
//  ShoppingAppTests
//
//  Created by Jan Kazubski on 10/05/2025.
//

import XCTest
@testable import ShoppingApp

final class BasketCalculatorTests: XCTestCase {
    func testCalculateTotalValueEmptyArray() {
        let products: [ProductEntity] = []
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "0.00 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductNoPromotion1() {
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "15.99 £",
                promotions: [],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 0
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "0.00 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductNoPromotion2() {
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "15.99 £",
                promotions: [],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 1
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "15.99 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductNoPromotion3() {
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "15.99 £",
                promotions: [],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 2
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "31.98 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductDiscountPromotion1() {
        let discountPromotion = PromotionEntity(type: "discount", value: "5.00 £")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "22.50 £",
                promotions: [discountPromotion],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 0
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "0.00 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductDiscountPromotion2() {
        let discountPromotion = PromotionEntity(type: "discount", value: "5.00 £")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "22.50 £",
                promotions: [discountPromotion],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 1
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "5.00 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductDiscountPromotion3() {
        let discountPromotion = PromotionEntity(type: "discount", value: "5.00 £")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "22.50 £",
                promotions: [discountPromotion],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 3
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "15.00 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductPercentagePromotion1() {
        let percentagePromotion = PromotionEntity(type: "percentage", value: "10%")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "89.99 £",
                promotions: [percentagePromotion],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 0
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "0.00 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductPercentagePromotion2() {
        let percentagePromotion = PromotionEntity(type: "percentage", value: "10%")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "89.99 £",
                promotions: [percentagePromotion],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 1
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "80.99 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductPercentagePromotion3() {
        let percentagePromotion = PromotionEntity(type: "percentage", value: "10%")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "89.99 £",
                promotions: [percentagePromotion],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 3
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "242.97 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueMultipleProducts() {
        let discountPromotion = PromotionEntity(type: "discount", value: "5.00 £")
        let percentagePromotion = PromotionEntity(type: "percentage", value: "10%")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "15.99 £",
                promotions: [],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 2
            ),
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "89.99 £",
                promotions: [percentagePromotion],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 0
            ),
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "22.50 £",
                promotions: [discountPromotion],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 3
            ),
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "89.99 £",
                promotions: [percentagePromotion],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 1
            ),
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "89.99 £",
                promotions: [percentagePromotion],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 0
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "127.97 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductMultiplePromotions1() {
        let percentagePromotion1 = PromotionEntity(type: "percentage", value: "5%")
        let percentagePromotion2 = PromotionEntity(type: "percentage", value: "10%")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "89.99 £",
                promotions: [percentagePromotion1, percentagePromotion2],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 1
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "80.99 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductMultiplePromotions2() {
        let percentagePromotion1 = PromotionEntity(type: "percentage", value: "10%")
        let percentagePromotion2 = PromotionEntity(type: "percentage", value: "10%")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "89.99 £",
                promotions: [percentagePromotion1, percentagePromotion2],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 1
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "80.99 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductMultiplePromotions3() {
        let discountPromotion1 = PromotionEntity(type: "discount", value: "10.00 £")
        let discountPromotion2 = PromotionEntity(type: "discount", value: "5.00 £")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "89.99 £",
                promotions: [discountPromotion1, discountPromotion2],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 1
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "5.00 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductMultiplePromotions4() {
        let discountPromotion1 = PromotionEntity(type: "discount", value: "5.00 £")
        let discountPromotion2 = PromotionEntity(type: "discount", value: "5.00 £")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "89.99 £",
                promotions: [discountPromotion1, discountPromotion2],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 1
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "5.00 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductMultiplePromotions5() {
        let discountPromotion = PromotionEntity(type: "discount", value: "9.00 £")
        let percentagePromotion = PromotionEntity(type: "percentage", value: "10%")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "10.00 £",
                promotions: [discountPromotion, percentagePromotion],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 1
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "9.00 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductMultiplePromotions6() {
        let discountPromotion = PromotionEntity(type: "discount", value: "6.00 £")
        let percentagePromotion = PromotionEntity(type: "percentage", value: "10%")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "10.00 £",
                promotions: [discountPromotion, percentagePromotion],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 1
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "6.00 £"
        
        XCTAssertEqual(result, expected)
    }
    
    func testCalculateTotalValueSingleProductMultiplePromotions7() {
        let discountPromotion = PromotionEntity(type: "discount", value: "9.00 £")
        let percentagePromotion = PromotionEntity(type: "percentage", value: "20%")
        let products = [
            ProductEntity(
                id: "test",
                productDescription: "test",
                price: "10.00 £",
                promotions: [discountPromotion, percentagePromotion],
                isFavorite: false,
                inStock: 10,
                imageName: "image.png",
                quantityInCart: 1
            )
        ]
        
        let result = BasketCalculator.calculateTotalValue(for: products)
        let expected = "8.00 £"
        
        XCTAssertEqual(result, expected)
    }
}
