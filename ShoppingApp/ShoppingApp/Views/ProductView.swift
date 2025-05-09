//
//  ProductView.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import SwiftUI

struct ProductView: View {
    @State private var quantity = 0
    @State private var isFavorite: Bool

    let product: Product

    init(product: Product) {
        self.product = product
        self._isFavorite = State(initialValue: product.isFavorite)
    }

    var body: some View {
        HStack(spacing: 0) {
            productImage
                .frame(width: 130)
                .clipped()

            VStack(alignment: .leading) {
                Text(product.description)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)

                Spacer()

                priceAndQuantity
            }
            .padding(10)
        }
        .frame(height: 150)
        .overlay(favoriteButton.padding(5), alignment: .topLeading)
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
            if let promotion = product.promotions.first {
                switch promotion.type {
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

            HStack(spacing: 0) {
                Button {
                    if quantity > 0 {
                        quantity -= 1
                    }
                } label: {
                    Image(systemName: "minus")
                        .foregroundStyle(.black)
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .background(Color.yellow.opacity(0.5))
                }
                .disabled(quantity == 0)
                
                Text("\(quantity)")
                    .foregroundStyle(.black)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 30)
                    .background(Color.white)
                
                Button {
                    if quantity < product.inStock {
                        quantity += 1
                    }
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .background(Color.yellow)
                }
                .disabled(quantity >= product.inStock)
            }
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
    
    private var favoriteButton: some View {
        Button {
            isFavorite.toggle()
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(.blue)
        }
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
    ProductView(product: Product(
        id: "f0e9d8c7-b6a5-4321-fedc-ba9876543210",
        description: "Stainless Steel Water Bottle",
        price: "22.50 £",
        promotions: [Promotion(type: PromotionType.discount, value: "5.00 £")],
        isFavorite: false,
        inStock: 120,
        imageName: "bottle.png"
    ))
}
