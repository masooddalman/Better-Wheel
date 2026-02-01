//
//  Better_WheelApp.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import SwiftUI

@main
struct Better_WheelApp: App {
    var body: some Scene {
        MenuBarExtra("Better Wheel", systemImage: AccessibilityManager.checkPermissions() ? "computermouse.fill" : "computermouse"){
            ContentView()
        }
    }
}
