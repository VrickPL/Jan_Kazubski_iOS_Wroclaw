//
//  ErrorView.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    var onRetry: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                Text("Error")
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Error")
            .font(.title)
            .bold()
            
            Text(error.localizedDescription)
                .multilineTextAlignment(.center)
                .accessibilityLabel("Error details")
                .accessibilityValue(error.localizedDescription)
            
            Button(action: onRetry) {
                Text("Try again")
                    .fontWeight(.semibold)
                    .cornerRadius(30)
                    .accessibilityLabel("Retry button")
                    .accessibilityHint("Tap to retry the action.")
            }
            .padding(.vertical, 4)
        }
        .padding()
        .cornerRadius(12)
        .background(Color.red.opacity(0.05))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.red, lineWidth: 2)
        )
        .padding(.horizontal, 40)
    }
}

#Preview {
    ErrorView(error: ProductListError.missingFile) {}
}
