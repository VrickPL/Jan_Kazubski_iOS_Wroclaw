//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import SwiftUI

struct ContentView: View {
    init() {
        UIScrollView.appearance().delaysContentTouches = false
    }
    
    var body: some View {
        TabView {
            ProductList()
                .tabItem {
                    Image(systemName: "square.grid.3x3.fill")
                    Text("Browse")
                }
            
            CheckoutView()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("Checkout")
                }
        }
    }
}

#Preview {
    ContentView()
}
