//
//  ContentView.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var isEnabled: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Enable/Disable toggle
            Toggle("Enable Better Wheel", isOn: $isEnabled)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .onChange(of: isEnabled) { oldValue, newValue in
                    Logger.log("Better Wheel \(newValue ? "enabled" : "disabled")", type: .info)
                }
            
            Divider()
            
            // Preferences button
            Button {
                openPreferences()
            } label: {
                Text("Preferences...")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            
            // Quit button
            Button {
                quitApp()
            } label: {
                Text("Quit Better Wheel")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
        }
        .frame(width: 220)
    }
    
    private func openPreferences() {
        PreferencesWindowManager.shared.openPreferences()
    }
    
    private func quitApp() {
        Logger.log("Quitting app", type: .info)
        NSApplication.shared.terminate(nil)
    }
}

#Preview {
    ContentView()
}
