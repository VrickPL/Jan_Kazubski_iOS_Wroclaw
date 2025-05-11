//
//  CheckoutViewTests.swift
//  ShoppingAppTests
//
//  Created by Jan Kazubski on 10/05/2025.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import ShoppingApp

final class CheckoutViewTests: XCTestCase {
    func testProductListStateDisplaysEmptyMessage() throws {
        let view = CheckoutView()
        let inspectedView = try view.inspect()
        
        let emptyText = try inspectedView
            .navigationStack()
            .find(ViewType.Text.self) { text in
                let label = try? text.accessibilityLabel().string()
                return label == "Empty product list"
            }
        let textString = try emptyText.string()
        XCTAssertEqual(textString, "The product list is empty.")
        XCTAssertThrowsError(try inspectedView.find(button: "Checkout"))
    }
}
