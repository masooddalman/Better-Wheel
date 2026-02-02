//
//  GeneralPreferencesView.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import SwiftUI

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

#Preview {
    GeneralPreferencesView()
}
