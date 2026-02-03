//
//  GeneralPreferencesView.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import SwiftUI
import ServiceManagement

struct GeneralPreferencesView: View {
    @EnvironmentObject var scrollEngine: ScrollEngine
    @State private var hasPermission = AccessibilityManager.checkPermissions()
    @State private var launchAtLogin = SMAppService.mainApp.status == .enabled
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Smooth Scroll Toggle Card
                HStack {
                    Text("Better Wheel:")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text(scrollEngine.isEnabled ? "ON" : "OFF")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(scrollEngine.isEnabled ? .blue : .secondary)
                    
                    Spacer()
                    
                    Toggle("", isOn: $scrollEngine.isEnabled)
                        .labelsHidden()
                        .toggleStyle(.switch)
                        .scaleEffect(1.2)
                        .onChange(of: scrollEngine.isEnabled) { oldValue, newValue in
                            scrollEngine.savePreferences()
                        }
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                .disabled(!hasPermission)
                .opacity(hasPermission ? 1.0 : 0.5)
                
                // Permission Warning (shown when no permission)
                if !hasPermission {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.orange)
                        
                        Text("Accessibility permission required")
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Button("Grant Permission") {
                            AccessibilityManager.openAccessibilitySettings()
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.small)
                    }
                    .padding()
                    .background(.orange.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
                
                // Launch at Login Card
                HStack {
                    Image(systemName: "power")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    
                    VStack(alignment: .leading){
                        Text("Launch at Login")
                            .font(.headline)
                        Text("Make mouse wheel smooth automatically when my Mac starts")
                            .font(.caption)
                            .foregroundStyle(Color(.gray))
                            
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $launchAtLogin)
                        .labelsHidden()
                        .toggleStyle(.switch)
                        .scaleEffect(1.2)
                        .onChange(of: launchAtLogin) { oldValue, newValue in
                            toggleLaunchAtLogin(enabled: newValue)
                        }
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                .disabled(!scrollEngine.isEnabled || !hasPermission)
                .opacity((scrollEngine.isEnabled && hasPermission) ? 1.0 : 0.5)
                
                // Speed & Smoothness Card
                VStack(alignment: .leading, spacing: 20) {
                    // Speed Slider
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "tortoise.fill")
                                .font(.title2)
                                .foregroundStyle(.secondary)
                            
                            Text("Speed")
                                .font(.headline)
                            
                            Spacer()
                            
                            Text(String(format: "%.1fx", scrollEngine.scrollMultiplier))
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                            
                            Image(systemName: "hare.fill")
                                .font(.title2)
                                .foregroundStyle(.secondary)
                        }
                        
                        Slider(value: $scrollEngine.scrollMultiplier, in: 0.5...3.0)
                            .tint(.blue)
                            .onChange(of: scrollEngine.scrollMultiplier) { oldValue, newValue in
                                scrollEngine.savePreferences()
                            }
                    }
                    
                    Divider()
                        .background(Color.white.opacity(0.1))
                    
                    // Momentum Slider
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "hand.tap.fill")
                                .font(.title2)
                                .foregroundStyle(.secondary)
                            
                            Text("Momentum")
                                .font(.headline)
                            
                            Spacer()
                            
                            Text(momentumLabel(for: scrollEngine.smoothingFactor))
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                            
                            Image(systemName: "figure.skateboarding")
                                .font(.title2)
                                .foregroundStyle(.secondary)
                        }
                        
                        Slider(value: $scrollEngine.smoothingFactor, in: 0.1...1.0)
                            .tint(.blue)
                            .onChange(of: scrollEngine.smoothingFactor) { oldValue, newValue in
                                scrollEngine.savePreferences()
                            }
                        
                        Text("Lower = Responsive control • Higher = Smooth gliding")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                .disabled(!scrollEngine.isEnabled || !hasPermission)
                .opacity((scrollEngine.isEnabled && hasPermission) ? 1.0 : 0.5)
                
                // Invert Scroll Direction Card
                HStack {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    
                    Text("Invert Scroll Direction")
                        .font(.headline)
                    
                    Spacer()
                    
                    Toggle("", isOn: $scrollEngine.invertScroll)
                        .labelsHidden()
                        .toggleStyle(.switch)
                        .scaleEffect(1.2)
                        .onChange(of: scrollEngine.invertScroll) { oldValue, newValue in
                            scrollEngine.savePreferences()
                        }
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                .disabled(!scrollEngine.isEnabled || !hasPermission)
                .opacity((scrollEngine.isEnabled && hasPermission) ? 1.0 : 0.5)
                
                Spacer()
            }
            .padding(24)
        }
        .navigationTitle("General")
        .background(Color(nsColor: .windowBackgroundColor))
        .onAppear {
            hasPermission = AccessibilityManager.checkPermissions()
            launchAtLogin = SMAppService.mainApp.status == .enabled
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("AccessibilityPermissionChanged"))) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                let currentPermission = AccessibilityManager.checkPermissions()
                
                // If permission was revoked and Better Wheel is ON, turn it OFF
                if !currentPermission && hasPermission && scrollEngine.isEnabled {
                    scrollEngine.isEnabled = false
                    Logger.log("Better Wheel turned OFF due to permission revocation", type: .warning)
                }
                
                // If permission was revoked and launch at login is ON, turn it OFF
                if !currentPermission && hasPermission && launchAtLogin {
                    toggleLaunchAtLogin(enabled: false)
                    Logger.log("Launch at login turned OFF due to permission revocation", type: .warning)
                }
                
                hasPermission = currentPermission
                Logger.log("Permission status changed to: \(hasPermission ? "GRANTED" : "DENIED")", type: hasPermission ? .success : .warning)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)) { _ in
            // Check permission when app becomes active (user returns from System Settings)
            let currentPermission = AccessibilityManager.checkPermissions()
            if currentPermission != hasPermission {
                withAnimation(.easeInOut(duration: 0.3)) {
                    // If permission was revoked and Better Wheel is ON, turn it OFF
                    if !currentPermission && hasPermission && scrollEngine.isEnabled {
                        scrollEngine.isEnabled = false
                        Logger.log("Better Wheel turned OFF due to permission revocation", type: .warning)
                    }
                    
                    // If permission was revoked and launch at login is ON, turn it OFF
                    if !currentPermission && hasPermission && launchAtLogin {
                        toggleLaunchAtLogin(enabled: false)
                        Logger.log("Launch at login turned OFF due to permission revocation", type: .warning)
                    }
                    
                    hasPermission = currentPermission
                    Logger.log("Permission status changed to: \(hasPermission ? "GRANTED" : "DENIED")", type: hasPermission ? .success : .warning)
                }
            }
        }
    }
    
    // MARK: - Momentum Label Helper
    
    private func momentumLabel(for value: Double) -> String {
        if value < 0.35 {
            // Precise range: 0.1 to 0.349
            // 0.1 = 100%, 0.349 = 1%
            let percentage = Int((1.0 - (value - 0.1) / (0.35 - 0.1)) * 100)
            return "\(percentage)% Precise"
        } else if value <= 0.65 {
            // Balanced range: 0.35 to 0.65
            return "Balanced"
        } else {
            // Glide range: 0.651 to 1.0
            // 0.651 = 1%, 1.0 = 100%
            let percentage = Int((value - 0.65) / (1.0 - 0.65) * 100)
            return "\(percentage)% Glide"
        }
    }
    
    // MARK: - Launch at Login
    
    private func toggleLaunchAtLogin(enabled: Bool) {
        do {
            if enabled {
                try SMAppService.mainApp.register()
                Logger.log("Launch at login enabled", type: .success)
            } else {
                try SMAppService.mainApp.unregister()
                Logger.log("Launch at login disabled", type: .info)
            }
        } catch {
            Logger.log("Failed to toggle launch at login: \(error.localizedDescription)", type: .error)
            // Revert the toggle if it failed
            launchAtLogin = !enabled
        }
    }
}

#Preview {
    GeneralPreferencesView()
        .environmentObject(ScrollEngine())
        .frame(width: 500, height: 600)
}
