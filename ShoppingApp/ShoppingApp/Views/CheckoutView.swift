//
//  CheckoutView.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 10/05/2025.
//

import SwiftUI

struct CheckoutView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Color.purple.frame(height: 700)
                }
                
                Button {
                    // TODO: show alert
                } label: {
                    HStack {
                        Spacer()
                        Text("Checkout")
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    .padding(12)
                    .background(Color.yellow)
                    .cornerRadius(10)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
            }
            .navigationTitle("Checkout")
        }
    }
}

#Preview {
    CheckoutView()
}
