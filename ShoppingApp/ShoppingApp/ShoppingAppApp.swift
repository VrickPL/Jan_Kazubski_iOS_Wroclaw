//
//  ShoppingAppApp.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 09/05/2025.
//

import SwiftUI
import SwiftData

@main
struct ShoppingAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ProductEntity.self)
        }
    }
}
