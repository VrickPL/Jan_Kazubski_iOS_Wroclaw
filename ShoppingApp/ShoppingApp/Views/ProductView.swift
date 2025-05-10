//
//  ProductView.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import SwiftUI
import SwiftData

struct ProductView: View {
    @Environment(\.modelContext) private var modelContext

    let product: ProductEntity

    var body: some View {
        HStack(spacing: 0) {
            productImage
                .frame(width: 130)
                .clipped()
                .accessibilityHidden(true)

            VStack(alignment: .leading) {
                Text(product.productDescription)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .accessibilityLabel("Product")
                    .accessibilityValue(product.productDescription)
                    .accessibilitySortPriority(6)

                Spacer()

                priceAndQuantity
            }
            .padding(10)
        }
        .frame(height: 150)
        .overlay(favoriteButton, alignment: .topLeading)
        .background(Color.yellow.opacity(0.1))
        .cornerRadius(10)
        .accessibilityElement(children: .contain)
    }
    
    private var productImage: some View {
        ZStack {
            Color.backgroundPrimary
            ProductImage(imageName: product.imageName)
        }
    }
    
    private var priceAndQuantity: some View {
        VStack(alignment: .leading, spacing: 2) {
            if let promotion = product.theBiggestDiscountPromotionEntity {
                promotionView(for: promotion)
                    .accessibilitySortPriority(5)
            } else {
                Text(product.price)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.red)
                    .accessibilityLabel("Price")
                    .accessibilityValue(product.price)
                    .accessibilitySortPriority(5)
            }
            quantityControl
        }
    }
    
    @ViewBuilder
    private func promotionView(for promotion: PromotionEntity) -> some View {
        if let promotionType = PromotionType(rawValue: promotion.type) {
            switch promotionType {
            case .percentage:
                HStack(spacing: 8) {
                    Text(product.price)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.red)
                        .strikethrough()
                        .accessibilityLabel("Original price")
                        .accessibilityValue(product.price)
                    Text("-\(promotion.value)")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.red)
                        .accessibilityLabel("Discount")
                        .accessibilityValue("\(promotion.value) off")
                }
            case .discount:
                HStack(spacing: 8) {
                    Text(promotion.value)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.red)
                        .accessibilityLabel("Discounted price")
                        .accessibilityValue(promotion.value)
                    Text(product.price)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .strikethrough()
                        .accessibilityLabel("Original price")
                        .accessibilityValue(product.price)
                }
            }
        } else {
            Text(product.price)
                .font(.title3)
                .bold()
                .foregroundColor(.red)
                .accessibilityLabel("Price")
                .accessibilityValue(product.price)
        }
    }
    
    private var quantityControl: some View {
        HStack(spacing: 0) {
            Button {
                if product.quantityInCart > 0 {
                    product.quantityInCart -= 1
                    try? modelContext.save()
                }
            } label: {
                Image(systemName: "minus")
                    .foregroundStyle(.black)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 30)
                    .background(Color.yellow.opacity(0.5))
            }
            .accessibilityLabel("Decrease quantity")
            .accessibilityHint("Tap to decrease the quantity of \(product.productDescription)")
            .accessibilitySortPriority(2)
            .disabled(product.quantityInCart <= 0)
            
            Text("\(product.quantityInCart)")
                .foregroundStyle(.black)
                .bold()
                .frame(maxWidth: .infinity, maxHeight: 30)
                .background(Color.white)
                .accessibilityLabel("Quantity")
                .accessibilityValue("\(product.quantityInCart)")
                .accessibilitySortPriority(3)
            
            Button {
                if product.quantityInCart < product.inStock {
                    product.quantityInCart += 1
                    try? modelContext.save()
                }
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.black)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 30)
                    .background(Color.yellow)
            }
            .accessibilityLabel("Increase quantity")
            .accessibilityHint("Tap to increase the quantity of \(product.productDescription)")
            .accessibilitySortPriority(1)
            .disabled(product.quantityInCart >= product.inStock)
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .accessibilityElement(children: .contain)
    }
    
    private var favoriteButton: some View {
        Button {
            product.isFavorite.toggle()
            try? modelContext.save()
        } label: {
            Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                .foregroundColor(.blue)
                .padding(4)
                .background(Circle().foregroundStyle(Color.backgroundPrimary))
        }
        .padding(3)
        .accessibilityLabel(product.isFavorite ? "Remove from favorites" : "Add to favorites")
        .accessibilityHint("Double-tap to toggle favorite status for \(product.productDescription).")
        .accessibilitySortPriority(4)
    }
}

private struct ProductImage: View {
    let imageName: String

    var body: some View {
        if let uiImage = UIImage(named: imageName) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
        } else {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .padding()
        }
    }
}

#Preview {
    ProductView(
        product: ProductEntity(
            from: Product(
                id: "f0e9d8c7-b6a5-4321-fedc-ba9876543210",
                description: "Stainless Steel Water Bottle",
                price: "22.50 £",
                promotions: [Promotion(type: PromotionType.discount, value: "5.00 £")],
                isFavorite: false,
                inStock: 120,
                imageName: "bottle.png"
            )
        )
    )
}
