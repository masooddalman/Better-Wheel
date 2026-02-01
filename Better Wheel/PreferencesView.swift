//
//  PreferencesView.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import SwiftUI

struct PreferencesView: View {
    @State private var selectedSection: PreferenceSection = .general
    
    var body: some View {
        NavigationSplitView {
            // Sidebar
            List(PreferenceSection.allCases, selection: $selectedSection) { section in
                NavigationLink(value: section) {
                    Label(section.title, systemImage: section.icon)
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200, max: 250)
        } detail: {
            // Detail View
            Group {
                switch selectedSection {
                case .general:
                    GeneralPreferencesView()
                case .permissions:
                    PermissionsPreferencesView()
                case .tutorial:
                    TutorialPreferencesView()
                case .about:
                    AboutPreferencesView()
                }
            }
            .frame(minWidth: 500, minHeight: 400)
        }
        .frame(minWidth: 700, minHeight: 400)
    }
}

// MARK: - Preference Sections
enum PreferenceSection: String, CaseIterable, Identifiable {
    case general
    case permissions
    case tutorial
    case about
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .general:
            return "General"
        case .permissions:
            return "Permissions"
        case .tutorial:
            return "Tutorial"
        case .about:
            return "About"
        }
    }
    
    var icon: String {
        switch self {
        case .general:
            return "gearshape"
        case .permissions:
            return "lock.shield"
        case .tutorial:
            return "book"
        case .about:
            return "info.circle"
        }
    }
}

// MARK: - General Preferences
struct GeneralPreferencesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "gearshape.fill")
                .font(.system(size: 60))
                .foregroundStyle(.blue.gradient)
                .padding(.top, 40)
            
            Text("General Preferences")
                .font(.title)
            
            Text("Configure your scroll wheel settings")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle("General")
    }
}

// MARK: - Permissions Preferences
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
                .buttonStyle(.glass)
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

// MARK: - Tutorial Preferences
struct TutorialPreferencesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "book.fill")
                .font(.system(size: 60))
                .foregroundStyle(.purple.gradient)
                .padding(.top, 40)
            
            Text("How to Use Better Wheel")
                .font(.title)
            
            Text("Learn how to customize your scrolling experience")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Tutorial")
    }
}

// MARK: - About Preferences
struct AboutPreferencesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "computermouse.fill")
                .font(.system(size: 60))
                .foregroundStyle(.cyan.gradient)
                .padding(.top, 40)
            
            Text("Better Wheel")
                .font(.title)
            
            Text("Version 1.0.0")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Text("Created by MasoodDalman")
                .font(.caption)
                .foregroundStyle(.tertiary)
                .padding(.top, 8)
            
            Spacer()
        }
        .padding()
        .navigationTitle("About")
    }
}

#Preview {
    PreferencesView()
}
