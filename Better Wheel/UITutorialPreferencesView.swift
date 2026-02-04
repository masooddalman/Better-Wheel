//
//  TutorialPreferencesView.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import SwiftUI

struct TutorialPreferencesView: View {
    @State private var currentStep = 0
    
    var body: some View {
        VStack(spacing: 0) {

            // Tutorial content
            TabView(selection: $currentStep) {
                ForEach(0..<tutorialSteps.count, id: \.self) { index in
                    TutorialStepView(step: tutorialSteps[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.tabBarOnly)
            
            // Navigation buttons
            HStack(spacing: 12) {
                if currentStep > 0 {
                    Button {
                        withAnimation {
                            currentStep -= 1
                        }
                    } label: {
                        Label("Previous", systemImage: "chevron.left")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                
                if currentStep < tutorialSteps.count - 1 {
                    Button {
                        withAnimation {
                            currentStep += 1
                        }
                    } label: {
                        Label("Next", systemImage: "chevron.right")
                            .labelStyle(.titleAndIcon)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .keyboardShortcut(.return)
                } else {
                    Button {
                        //go to first step
                        DispatchQueue.main.async {
                            currentStep = 0
                        }
                    } label: {
                        Label("Done", systemImage: "checkmark")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .keyboardShortcut(.return)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
            .padding(.top, 8)
        }
        .navigationTitle("Tutorial")
    }
    
    private let tutorialSteps: [TutorialStep] = [
        TutorialStep(
            title: "Welcome to Better Wheel!",
            description: "Transform your mouse wheel scrolling into a smooth, natural experience on macOS.",
            assetImageName: "icon",
            details: [
                "✨ Smooth momentum-based scrolling",
                "⚡️ Adjustable speed and momentum",
                "🎯 Precise control when you need it",
                "🔄 Customizable scroll direction"
            ]
        ),
        TutorialStep(
            title: "Step 1: Grant Permissions",
            description: "After installation, you need to enable Accessibility permissions in System Settings.",
            assetImageName: "osPermission",
            details: [
                "1. Click 'Open System Settings' when prompted",
                "2. Find 'Better Wheel' in the list",
                "3. Toggle the switch to enable access",
                "4. Return to Better Wheel"
            ],
            noteText: "⚠️ This permission is required for Better Wheel to intercept and smooth your scroll events."
        ),
        TutorialStep(
            title: "Step 2: Check the Menu Bar",
            description: "The app icon in the menu bar changes when permission is granted.",
            customContent: AnyView(
                VStack(spacing: 24) {
                    HStack(spacing: 40) {
                        VStack(spacing: 12) {
                            Image(systemName:"computermouse")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                            Text("No Permission")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Image(systemName: "arrow.right")
                            .font(.title2)
                            .foregroundStyle(.blue)
                        
                        VStack(spacing: 12) {
                            Image(systemName:"computermouse.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                            Text("Permission Granted ✓")
                                .font(.caption)
                                .foregroundStyle(.green)
                                .fontWeight(.medium)
                        }
                    }
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            )
        ),
        TutorialStep(
            title: "Better Wheel Toggle",
            description: "The main switch to enable or disable smooth scrolling.",
            systemImage: "power",
            imageGradient: [.blue, .cyan],
            details: [
                "🟢 ON: Smooth scrolling is active",
                "⚪️ OFF: Normal system scrolling",
                "Quickly toggle anytime from the menu bar"
            ],
            noteText: "💡 Tip: All other controls are disabled when Better Wheel is OFF."
        ),
        TutorialStep(
            title: "Launch at Login",
            description: "Make Better Wheel start automatically when your Mac boots up.",
            systemImage: "power.circle.fill",
            imageGradient: [.green, .mint],
            details: [
                "Enable to start Better Wheel on system startup",
                "Your scroll settings persist between restarts",
                "Seamless smooth scrolling from the moment you log in"
            ]
        ),
        TutorialStep(
            title: "Speed Control",
            description: "Adjust how fast your content scrolls with each wheel movement.",
            customContent: AnyView(
                VStack(spacing: 20) {
                    HStack(spacing: 16) {
                        Image(systemName: "tortoise.fill")
                            .font(.title)
                            .foregroundStyle(.secondary)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("0.5x - 3.0x")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("Drag to adjust")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "hare.fill")
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• Lower values: Slower, more controlled scrolling")
                        Text("• Higher values: Faster movement through content")
                        Text("• Default (1.0x) matches typical scroll speed")
                    }
                    .font(.callout)
                    .foregroundStyle(.secondary)
                }
            )
        ),
        TutorialStep(
            title: "Momentum Control",
            description: "Fine-tune how your scrolling feels with momentum adjustment.",
            customContent: AnyView(
                VStack(spacing: 20) {
                    HStack(spacing: 16) {
                        Image(systemName: "hand.tap.fill")
                            .font(.title)
                            .foregroundStyle(.secondary)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Precise ↔ Glide")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("Find your perfect feel")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "figure.skateboarding")
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• Low values: Responsive, precise control")
                            .foregroundStyle(.blue)
                        Text("• Middle: Balanced feel")
                            .foregroundStyle(.purple)
                        Text("• High values: Smooth gliding with momentum")
                            .foregroundStyle(.green)
                    }
                    .font(.callout)
                }
            ),
            noteText: "🎯 Lower values feel more like traditional mouse wheels. Higher values feel more like trackpad scrolling."
        ),
        TutorialStep(
            title: "Invert Scroll Direction",
            description: "Reverse the scroll direction to match your preference.",
            systemImage: "arrow.up.arrow.down",
            imageGradient: [.purple, .pink],
            details: [
                "🔄 Match your trackpad scrolling direction",
                "Natural vs. Traditional scrolling",
                "Toggle instantly without system settings"
            ],
            noteText: "💡 If you use 'Natural' scrolling on your trackpad, you might prefer inverted wheel scrolling."
        ),
        TutorialStep(
            title: "You're All Set!",
            description: "Enjoy your smooth scrolling experience. You can adjust settings anytime from the menu bar.",
            systemImage: "checkmark.circle.fill",
            imageGradient: [.green, .blue],
            details: [
                "🎉 All features are now at your fingertips",
                "⚙️ Access preferences from the menu bar",
                "📊 Experiment with settings to find your perfect feel",
                "❤️ Enjoy smooth scrolling!"
            ]
        )
    ]
}

// MARK: - Tutorial Step Model

struct TutorialStep {
    let title: String
    let description: String
    var systemImage: String? = nil
    var assetImageName: String? = nil
    var imageGradient: [Color]? = nil
    var customContent: AnyView? = nil
    var details: [String]? = nil
    var noteText: String? = nil
}

// MARK: - Tutorial Step View

struct TutorialStepView: View {
    let step: TutorialStep
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header image
                if let customContent = step.customContent {
                    customContent
                        .padding(.horizontal)
                } else if let assetImageName = step.assetImageName {
                    Image(assetImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                        .padding(.top, 20)
                        .padding(.horizontal)
                } else if let systemImage = step.systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 70))
                        .foregroundStyle(
                            step.imageGradient.map { colors in
                                LinearGradient(
                                    colors: colors,
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            } ?? LinearGradient(
                                colors: [.blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .padding(.top, 20)
                }
                
                // Title and description
                VStack(spacing: 12) {
                    Text(step.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text(step.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal)
                
                // Details list
                if let details = step.details {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(details, id: \.self) { detail in
                            Text(detail)
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
                    .padding(.horizontal)
                }
                
                // Note
                if let noteText = step.noteText {
                    HStack(alignment: .top, spacing: 12) {
                        Text(noteText)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(16)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    TutorialPreferencesView()
        .frame(width: 500, height: 600)
}
