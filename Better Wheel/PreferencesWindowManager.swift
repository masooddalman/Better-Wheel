//
//  PreferencesWindowManager.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import SwiftUI
import AppKit

/// Manages the preferences window
class PreferencesWindowManager {
    static let shared = PreferencesWindowManager()
    
    private var preferencesWindow: NSWindow?
    private var scrollEngine: ScrollEngine?
    
    private init() {}
    
    /// Set the scroll engine reference
    func setScrollEngine(_ engine: ScrollEngine) {
        self.scrollEngine = engine
    }
    
    /// Opens the preferences window
    func openPreferences() {
        guard let scrollEngine = scrollEngine else {
            Logger.log("ScrollEngine not set in PreferencesWindowManager", type: .error)
            return
        }
        
        if let window = preferencesWindow {
            // If window already exists, bring it to front
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            Logger.log("Brought existing preferences window to front", type: .info)
        } else {
            // Create new window with environment object
            let preferencesView = PreferencesView()
                .environmentObject(scrollEngine)
            let hostingController = NSHostingController(rootView: preferencesView)
            
            let window = NSWindow(contentViewController: hostingController)
            window.title = "Better Wheel Preferences"
            window.styleMask = [.titled, .closable, .resizable, .fullSizeContentView]
            window.titlebarAppearsTransparent = true
            window.setContentSize(NSSize(width: 700, height: 400))
            window.center()
            
            // Make window non-restorable (fresh state each time)
            window.isReleasedWhenClosed = false
            
            self.preferencesWindow = window
            
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            
            Logger.log("Opened preferences window", type: .info)
        }
    }
    
    /// Closes the preferences window
    func closePreferences() {
        preferencesWindow?.close()
        preferencesWindow = nil
        Logger.log("Closed preferences window", type: .info)
    }
}
