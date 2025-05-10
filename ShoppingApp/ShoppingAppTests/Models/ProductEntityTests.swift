//
//  ProductEntityTests.swift
//  ShoppingAppTests
//
//  Created by Jan Kazubski on 10/05/2025.
//

import XCTest
@testable import ShoppingApp

final class ProductEntityTests: XCTestCase {
    func testInitFromProduct1() {
        let product = Product(
            id: "123",
            description: "Test product",
            price: "15.99 £",
            promotions: [
                Promotion(type: .discount, value: "5.00 £"),
                Promotion(type: .percentage, value: "10%")
            ],
            isFavorite: true,
            inStock: 20,
            imageName: "test.png"
        )
        
        let entity = ProductEntity(from: product)
        
        XCTAssertEqual(entity.id, product.id)
        XCTAssertEqual(entity.productDescription, product.description)
        XCTAssertEqual(entity.price, product.price)
        XCTAssertEqual(entity.promotions.count, product.promotions.count)
        XCTAssertEqual(entity.isFavorite, product.isFavorite)
        XCTAssertEqual(entity.inStock, product.inStock)
        XCTAssertEqual(entity.imageName, product.imageName)
        XCTAssertEqual(entity.quantityInCart, 0)
        
        for productPromotion in product.promotions {
            XCTAssertTrue(entity.promotions.contains(where: { $0.type == productPromotion.type.rawValue && $0.value == productPromotion.value}))
        }
    }

    func testInitFromProduct2() {
        let product = Product(
            id: "456",
            description: "Test product",
            price: "15.99 £",
            promotions: [],
            isFavorite: true,
            inStock: 20,
            imageName: "test.png"
        )
        
        let entity = ProductEntity(from: product)
        
        XCTAssertEqual(entity.id, product.id)
        XCTAssertEqual(entity.productDescription, product.description)
        XCTAssertEqual(entity.price, product.price)
        XCTAssertEqual(entity.promotions.count, product.promotions.count)
        XCTAssertEqual(entity.isFavorite, product.isFavorite)
        XCTAssertEqual(entity.inStock, product.inStock)
        XCTAssertEqual(entity.imageName, product.imageName)
        XCTAssertEqual(entity.quantityInCart, 0)
        
        for productPromotion in product.promotions {
            XCTAssertTrue(entity.promotions.contains(where: { $0.type == productPromotion.type.rawValue && $0.value == productPromotion.value}))
        }
    }
    
    func testNumericPrice1() {
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "0.00 £",
            promotions: [],
            isFavorite: false,
            inStock: 10,
            imageName: "numeric.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.numericPrice, 0.0)
    }
    
    func testNumericPrice2() {
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "19.99 £",
            promotions: [],
            isFavorite: false,
            inStock: 10,
            imageName: "numeric.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.numericPrice, 19.99)
    }
    
    func testNumericPrice3() {
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "20.00 £",
            promotions: [],
            isFavorite: false,
            inStock: 10,
            imageName: "numeric.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.numericPrice, 20.0)
    }
    
    func testNumericPrice4() {
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "20.00£",
            promotions: [],
            isFavorite: false,
            inStock: 10,
            imageName: "numeric.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.numericPrice, 0.0)
    }
    
    func testNumericPrice5() {
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "20.00 $",
            promotions: [],
            isFavorite: false,
            inStock: 10,
            imageName: "numeric.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.numericPrice, 20.0)
    }
    
    func testNumericPrice6() {
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "20.00 PLN",
            promotions: [],
            isFavorite: false,
            inStock: 10,
            imageName: "numeric.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.numericPrice, 20.0)
    }
    
    func testNumericPrice7() {
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "10 £",
            promotions: [],
            isFavorite: false,
            inStock: 10,
            imageName: "numeric.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.numericPrice, 10.0)
    }
    
    func testNumericPrice8() {
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "10£",
            promotions: [],
            isFavorite: false,
            inStock: 10,
            imageName: "numeric.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.numericPrice, 0.0)
    }
    
    func testNumericPrice9() {
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "",
            promotions: [],
            isFavorite: false,
            inStock: 10,
            imageName: "numeric.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.numericPrice, 0.0)
    }
    
    func testNumericPrice10() {
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: " £",
            promotions: [],
            isFavorite: false,
            inStock: 10,
            imageName: "numeric.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.numericPrice, 0.0)
    }
    
    func testNumericPrice11() {
        let discountPromotion = PromotionEntity(type: "discount", value: "5.00 £")
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "10.00 £",
            promotions: [discountPromotion],
            isFavorite: false,
            inStock: 10,
            imageName: "numeric.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.numericPrice, 10.0)
    }
    
    func testNumericPrice12() {
        let discountPromotion = PromotionEntity(type: "discount", value: "5.00 £")
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "",
            promotions: [discountPromotion],
            isFavorite: false,
            inStock: 10,
            imageName: "numeric.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.numericPrice, 0.0)
    }
    
    func testDiscountedPriceWithoutPromotions() {
        let productEntity = ProductEntity(
            id: "123",
            productDescription: "Test product",
            price: "10.00 £",
            promotions: [],
            isFavorite: false,
            inStock: 5,
            imageName: "nopromo.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.discountedPrice, 10.0)
    }
    
    func testDiscountedPriceWithDiscountPromotion() {
        let discountPromotion = PromotionEntity(type: "discount", value: "5.00 £")
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "22.50 £",
            promotions: [discountPromotion],
            isFavorite: false,
            inStock: 8,
            imageName: "discount.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.discountedPrice, 5.00)
    }
    
    func testDiscountedPriceWithPercentagePromotion() {
        let percentagePromotion = PromotionEntity(type: "percentage", value: "10%")
        let productEntity = ProductEntity(
            id: "123",
            productDescription: "Test product",
            price: "100.00 £",
            promotions: [percentagePromotion],
            isFavorite: false,
            inStock: 15,
            imageName: "percentage.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.discountedPrice, 90.0)
    }
    
    func testTheBiggestDiscountWithoutPromotions() {
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "100.00 £",
            promotions: [],
            isFavorite: false,
            inStock: 12,
            imageName: "multipromo.png",
            quantityInCart: 0
        )
        
        XCTAssertNil(productEntity.theBiggestDiscount)
        XCTAssertNil(productEntity.theBiggestDiscountPromotionEntity)
    }
    
    func testTheBiggestDiscountWithMultiplePromotions1() {
        let discountPromotion = PromotionEntity(type: "discount", value: "80.00 £")
        let percentagePromotion = PromotionEntity(type: "percentage", value: "10%")
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "100.00 £",
            promotions: [discountPromotion, percentagePromotion],
            isFavorite: false,
            inStock: 12,
            imageName: "multipromo.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.theBiggestDiscount!, 80.00)
        
        let bestPromotion = productEntity.theBiggestDiscountPromotionEntity
        XCTAssertNotNil(bestPromotion)
        XCTAssertEqual(bestPromotion?.type, "discount")
        XCTAssertEqual(bestPromotion?.value, "80.00 £")
    }
    
    func testTheBiggestDiscountWithMultiplePromotions2() {
        let discountPromotion = PromotionEntity(type: "discount", value: "95.00 £")
        let percentagePromotion = PromotionEntity(type: "percentage", value: "10%")
        let productEntity = ProductEntity(
            id: "321",
            productDescription: "Test product",
            price: "100.00 £",
            promotions: [discountPromotion, percentagePromotion],
            isFavorite: false,
            inStock: 12,
            imageName: "multipromo.png",
            quantityInCart: 0
        )
        
        XCTAssertEqual(productEntity.theBiggestDiscount!, 90.00)
        
        let bestPromotion = productEntity.theBiggestDiscountPromotionEntity
        XCTAssertNotNil(bestPromotion)
        XCTAssertEqual(bestPromotion?.type, "percentage")
        XCTAssertEqual(bestPromotion?.value, "10%")
    }
    
    func testDiscountedPriceDiscountValid() {
        let promotion = PromotionEntity(type: "discount", value: "5.00 £")
        let defaultPrice = 100.0
        let discounted = promotion.discountedPrice(defaultPrice: defaultPrice)
        
        XCTAssertEqual(discounted, 5.00)
    }
    
    func testDiscountedPricePercentageValid() {
        let promotion = PromotionEntity(type: "percentage", value: "10%")
        let defaultPrice = 200.0
        let discounted = promotion.discountedPrice(defaultPrice: defaultPrice)
        
        XCTAssertEqual(discounted, 180.0)
    }
    
    func testDiscountedPriceDiscountInvalidValue() {
        let promotion = PromotionEntity(type: "discount", value: "abc £")
        let defaultPrice = 150.0
        
        XCTAssertEqual(promotion.discountedPrice(defaultPrice: defaultPrice), 0.0)
    }
    
    func testDiscountedPricePercentageInvalidValue() {
        let promotion = PromotionEntity(type: "percentage", value: "abc%")
        let defaultPrice = 250.0
        
        XCTAssertEqual(promotion.discountedPrice(defaultPrice: defaultPrice), 250.0)
    }
    
    func testDiscountedPriceWithInvalidPromotionType() {
        let promotion = PromotionEntity(type: "aaa", value: "100")
        let defaultPrice = 50.0
        
        XCTAssertEqual(promotion.discountedPrice(defaultPrice: defaultPrice), defaultPrice)
    }
    
    func testDiscountedPriceDiscountWithExtraSpaces() {
        let promotion = PromotionEntity(type: "discount", value: "   5.0   £")
        let defaultPrice = 80.0
        
        XCTAssertEqual(promotion.discountedPrice(defaultPrice: defaultPrice), 5.0)
    }
    
    func testDiscountedPricePercentageZero() {
        let promotion = PromotionEntity(type: "percentage", value: "0%")
        let defaultPrice = 120.0
        
        XCTAssertEqual(promotion.discountedPrice(defaultPrice: defaultPrice), 120.0)
    }
    
    func testDiscountedPricePercentageOneHundred() {
        let promotion = PromotionEntity(type: "percentage", value: "100%")
        let defaultPrice = 120.0
        
        XCTAssertEqual(promotion.discountedPrice(defaultPrice: defaultPrice), 0.0)
    }
    
    func testDiscountedPricePercentageOver100() {
        let promotion = PromotionEntity(type: "percentage", value: "150%")
        let defaultPrice = 100.0
        
        XCTAssertEqual(promotion.discountedPrice(defaultPrice: defaultPrice), -50.0)
    }
}
