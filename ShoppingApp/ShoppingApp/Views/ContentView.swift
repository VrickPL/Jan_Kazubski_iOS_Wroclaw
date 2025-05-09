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
        ProductList()
    }
}

#Preview {
    ContentView()
}
