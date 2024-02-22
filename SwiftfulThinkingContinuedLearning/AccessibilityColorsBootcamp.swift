//
//  AccessibilityColorsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 22.02.24.
//

import SwiftUI

struct AccessibilityColorsBootcamp: View {
    
    @Environment(\.accessibilityReduceTransparency) var accessibilityReduceTransparency
    @Environment(\.colorSchemeContrast) var colorSchemeContrast
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityInvertColors) var accessibilityInvertColors

    var body: some View {
        NavigationStack {
            VStack {
                Button("Button 1") { }
                    .foregroundStyle(colorSchemeContrast == .increased ? .white: .primary)
                    .buttonStyle(.borderedProminent)
                
                Button("Button 2") { }
                    .foregroundStyle(.primary)
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                
                Button("Button 3") { }
                    .foregroundStyle(.white)
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                
                Button("Button 4") { }
                    .foregroundStyle(accessibilityDifferentiateWithoutColor ? .white : .green)
                    .buttonStyle(.borderedProminent)
                    .tint(accessibilityDifferentiateWithoutColor ? .black : .purple)
            }
            .font(.largeTitle)
        }
        //        .navigationTitle("Hi")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(accessibilityReduceTransparency ? Color.black : Color.black.opacity(0.5))
    }
}

#Preview {
    AccessibilityColorsBootcamp()
}
