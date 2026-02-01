//
//  AccessibilityManager.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import Foundation
import ApplicationServices
import AppKit

/// Manages accessibility permissions
class AccessibilityManager {
    
    /// Check if the app has accessibility permissions
    static func checkPermissions() -> Bool {
        let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: false]
        let trusted = AXIsProcessTrustedWithOptions(options as CFDictionary)
        Logger.log("Accessibility permission check \(trusted ? "GRANTED" : "DENIED")", type: trusted ? .success : .error)
        return trusted
    }
    
    /// Show an alert requesting accessibility permissions
    static func showPermissionAlert() {
        let alert = NSAlert()
        alert.messageText = "Accessibility Permission Required"
        alert.informativeText = "Better Wheel needs accessibility permissions to intercept and modify scroll events.\n\nSteps:\n1. Click 'Open System Settings'\n2. Enable Better Wheel in the Accessibility list\n3. QUIT and RESTART ScrollFix\n\nThe app MUST be restarted after granting permission!"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Open System Settings")
        alert.addButton(withTitle: "Quit App")
        alert.addButton(withTitle: "Later")
        
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            openAccessibilitySettings()
        } else if response == .alertSecondButtonReturn {
            NSApplication.shared.terminate(nil)
        }
    }
    
    /// Open System Settings to the Accessibility pane
    static func openAccessibilitySettings() {
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") {
            NSWorkspace.shared.open(url)
        }
    }
}
