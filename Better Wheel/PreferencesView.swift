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

#Preview {
    PreferencesView()
}
