//
//  AccessibilityVoiceOverBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 3.04.24.
//

import SwiftUI

struct AccessibilityVoiceOverBootcamp: View {
    @State private var isActive = false
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Volume", isOn: $isActive)
                    
                    HStack {
                        Text("Volume")
                        Spacer()
                        Text(isActive ? "TRUE" : "FALSE")
                            .accessibilityHidden(true)
                    }
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        isActive.toggle()
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityAddTraits(.isButton)
                    .accessibilityValue(isActive ? "is on" : "is off")
                    .accessibilityHint("Double tap to toggle setting.")
                    .accessibilityAction {
                        isActive.toggle()
                    }
                    
                } header: {
                    Text("Preferences")
                }
                
                Section {
                    Button("Favorites") { }
                        .accessibilityRemoveTraits(.isButton)
                    Button { } label: {
                        Image(systemName: "heart.fill")
                    }
                    .accessibilityLabel("Favorites")
                    
                    Text("Favorites")
                        .accessibilityAddTraits(.isButton)
                        .onTapGesture { }
                } header: {
                    Text("Application")
                }
                
                VStack {
                    Text("CONTENT")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondary)
                        .font(.caption)
                        .accessibilityAddTraits(.isHeader)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(0..<10) { i in
                                VStack {
                                    Image("steve-jobs")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    
                                    Text("Item \(i)")
                                }
                                .onTapGesture {
                                    
                                }
                                .accessibilityElement(children: .combine)
                                .accessibilityAddTraits(.isButton)
                                .accessibilityLabel("Item \(i). Image of Steve Jobs.")
                                .accessibilityHint("Double tap to open.")
                                .accessibilityAction {
                                    
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    AccessibilityVoiceOverBootcamp()
}
