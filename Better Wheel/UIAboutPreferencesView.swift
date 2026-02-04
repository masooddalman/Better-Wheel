//
//  AboutPreferencesView.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import SwiftUI

struct AboutPreferencesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // App Icon
                Image("AppIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .padding(.top, 40)
                
                // App Name and Version
                VStack(spacing: 8) {
                    Text("Better Wheel")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Version 1.0.1")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                // Description
                VStack(alignment: .leading, spacing: 16) {
                    Text("About Better Wheel")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Better Wheel transforms your traditional mouse wheel scrolling into a smooth, momentum-based experience similar to trackpad scrolling on macOS.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("The app intercepts mouse wheel events and applies customizable smoothing algorithms to create natural, fluid scrolling with adjustable speed and momentum.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                
                // Features
                VStack(alignment: .leading, spacing: 12) {
                    Text("Key Features")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    FeatureRow(icon: "waveform.path", text: "Smooth momentum-based scrolling")
                    FeatureRow(icon: "speedometer", text: "Adjustable scroll speed (0.5x - 3.0x)")
                    FeatureRow(icon: "slider.horizontal.3", text: "Customizable momentum control")
                    FeatureRow(icon: "arrow.up.arrow.down", text: "Invertible scroll direction")
                    FeatureRow(icon: "power", text: "Quick toggle on/off")
                    FeatureRow(icon: "gearshape.fill", text: "Launch at login support")
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                
                // GitHub Link
                Link(destination: URL(string: "https://github.com/masooddalman/Better-Wheel")!) {
                    HStack(spacing: 12) {
                        Image(systemName: "chevron.left.forwardslash.chevron.right")
                            .font(.title3)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("View on GitHub")
                                .font(.headline)
                            Text("github.com/masooddalman/Better-Wheel")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.forward")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
                
                // Creator Info
                VStack(spacing: 8) {
                    Text("Created by")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                    
                    Text("Masood Dalman")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 8)
                
                // Copyright
                Text("© 2026 Better Wheel. All rights reserved.")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                    .padding(.bottom, 40)
                
                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .navigationTitle("About")
    }
}

// MARK: - Feature Row

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.body)
                .foregroundStyle(.blue)
                .frame(width: 20)
            
            Text(text)
                .font(.body)
            
            Spacer()
        }
    }
}

#Preview {
    AboutPreferencesView()
        .frame(width: 500, height: 600)
}
