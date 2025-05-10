//
//  ErrorViewUITests.swift
//  ShoppingApp
//
//  Created by Jan Kazubski on 10/05/2025.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import ShoppingApp

final class ErrorViewTests: XCTestCase {
    func testErrorViewDisplaysCorrectElements() throws {
        let error = NSError(domain: "TestDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error message"])
        var retryCalled = false
        
        let view = ErrorView(error: error, onRetry: { retryCalled = true })
        let inspected = try view.inspect()
        
        let errorTitle = try inspected.vStack().hStack(0).text(1).string()
        XCTAssertEqual(errorTitle, "Error")
        
        let errorDetails = try inspected.vStack().text(1).string()
        XCTAssertEqual(errorDetails, "Test error message")
        
        let button = try inspected.vStack().button(2)
        let buttonText = try button.labelView().text().string()
        XCTAssertEqual(buttonText, "Try again")
        try button.tap()
        XCTAssertTrue(retryCalled)
    }
}
