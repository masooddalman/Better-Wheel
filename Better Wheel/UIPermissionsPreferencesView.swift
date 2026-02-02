//
//  PermissionsPreferencesView.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import SwiftUI

struct PermissionsPreferencesView: View {
    @State private var hasPermission = AccessibilityManager.checkPermissions()
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: hasPermission ? "checkmark.shield.fill" : "lock.shield.fill")
                .font(.system(size: 60))
                .foregroundStyle(hasPermission ? Color.green.gradient : Color.orange.gradient)
                .padding(.top, 40)
            
            Text("Accessibility Permissions")
                .font(.title)
            
            Text(hasPermission ? "Permissions granted ✓" : "Permissions required")
                .font(.subheadline)
                .foregroundStyle(hasPermission ? .green : .secondary)
            
            if !hasPermission {
                Button {
                    AccessibilityManager.openAccessibilitySettings()
                } label: {
                    Text("Open System Settings")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.borderedProminent)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Permissions")
        .onAppear {
            hasPermission = AccessibilityManager.checkPermissions()
        }
    }
}

#Preview {
    PermissionsPreferencesView()
}
