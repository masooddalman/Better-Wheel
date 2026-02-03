//
//  GeneralPreferencesView.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import SwiftUI

struct GeneralPreferencesView: View {
    @EnvironmentObject var scrollEngine: ScrollEngine
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("Scroll Wheel Settings")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Customize your mouse wheel scrolling experience")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Divider()
                
                // Settings
                VStack(alignment: .leading, spacing: 20) {
                    // Smoothing Factor
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Smoothing")
                                .fontWeight(.medium)
                            Spacer()
                            Text(String(format: "%.2f", scrollEngine.smoothingFactor))
                                .foregroundStyle(.secondary)
                                .monospacedDigit()
                        }
                        
                        Slider(value: $scrollEngine.smoothingFactor, in: 0.1...1.0) {
                            Text("Smoothing")
                        } minimumValueLabel: {
                            Text("Smooth")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } maximumValueLabel: {
                            Text("Responsive")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .onChange(of: scrollEngine.smoothingFactor) { oldValue, newValue in
                            scrollEngine.savePreferences()
                        }
                        
                        Text("Lower values create smoother scrolling, higher values are more responsive")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                    
                    // Scroll Multiplier
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Scroll Speed")
                                .fontWeight(.medium)
                            Spacer()
                            Text(String(format: "%.1fx", scrollEngine.scrollMultiplier))
                                .foregroundStyle(.secondary)
                                .monospacedDigit()
                        }
                        
                        Slider(value: $scrollEngine.scrollMultiplier, in: 0.5...3.0) {
                            Text("Scroll Speed")
                        } minimumValueLabel: {
                            Text("Slow")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } maximumValueLabel: {
                            Text("Fast")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .onChange(of: scrollEngine.scrollMultiplier) { oldValue, newValue in
                            scrollEngine.savePreferences()
                        }
                        
                        Text("Adjust how far the page scrolls with each wheel tick")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                    
                    Divider()
                    
                    // Toggles
                    VStack(alignment: .leading, spacing: 12) {
                        Toggle(isOn: $scrollEngine.enableInertia) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Enable Better Wheel")
                                    .fontWeight(.medium)
                                Text("fixes jittery scrolling")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .onChange(of: scrollEngine.enableInertia) { oldValue, newValue in
                            scrollEngine.savePreferences()
                        }
                        
                        Toggle(isOn: $scrollEngine.invertScroll) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Invert Scroll Direction")
                                    .fontWeight(.medium)
                                Text("Reverse the scrolling direction")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .onChange(of: scrollEngine.invertScroll) { oldValue, newValue in
                            scrollEngine.savePreferences()
                        }
                        
                    }
                }
            }
            .padding(24)
        }
        .padding()
        .navigationTitle("General")
    }
}

#Preview {
    GeneralPreferencesView()
        .environmentObject(ScrollEngine())
}
