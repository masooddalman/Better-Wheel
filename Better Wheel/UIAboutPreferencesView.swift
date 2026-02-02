//
//  AboutPreferencesView.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import SwiftUI

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
    AboutPreferencesView()
}
