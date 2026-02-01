//
//  Better_WheelApp.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import SwiftUI

@main
struct Better_WheelApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        MenuBarExtra("Better Wheel", systemImage: AccessibilityManager.checkPermissions() ? "computermouse.fill" : "computermouse"){
            ContentView()
        }
    }
}
// MARK: - App Delegate
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        // First check without prompt to add app to list silently
        let optionsWithPrompt = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        _ = AXIsProcessTrustedWithOptions(optionsWithPrompt as CFDictionary)
        
        // Small delay to let the system process the above
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Now check again without prompt and show our custom alert if needed
            if !AccessibilityManager.checkPermissions() {
                AccessibilityManager.showPermissionAlert()
            }
        }
    }
}

