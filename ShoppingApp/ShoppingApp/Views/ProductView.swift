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

            VStack(alignment: .leading) {
                Text(product.productDescription)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)

                Spacer()

                priceAndQuantity
            }
            .padding(10)
        }
        .frame(height: 150)
        .overlay(favoriteButton, alignment: .topLeading)
        .background(Color.yellow.opacity(0.1))
        .cornerRadius(10)
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
            } else {
                Text(product.price)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.red)
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
                    Text("-\(promotion.value)")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.red)
                }
            case .discount:
                HStack(spacing: 8) {
                    Text(promotion.value)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.red)
                    Text(product.price)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .strikethrough()
                }
            }
        } else {
            Text(product.price)
                .font(.title3)
                .bold()
                .foregroundColor(.red)
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
            .disabled(product.quantityInCart <= 0)
            
            Text("\(product.quantityInCart)")
                .foregroundStyle(.black)
                .bold()
                .frame(maxWidth: .infinity, maxHeight: 30)
                .background(Color.white)
            
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
            .disabled(product.quantityInCart >= product.inStock)
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
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
