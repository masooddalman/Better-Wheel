//
//  TutorialPreferencesView.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import SwiftUI

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

#Preview {
    TutorialPreferencesView()
}
