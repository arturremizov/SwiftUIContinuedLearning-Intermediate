//
//  AccessibilityTextBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 13.09.23.
//

import SwiftUI

struct AccessibilityTextBootcamp: View {
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<10) { _ in
                    VStack(alignment: .leading, spacing: 8.0) {
                        HStack {
                            Image(systemName: "heart.fill")
//                                .font(.system(size: 20))
                            Text("Welcome to my app")
                                .truncationMode(.tail)
                        }
                        .font(.title)
                        Text("This is some longer text that expands to multiple lines.")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                            .minimumScaleFactor(dynamicTypeSize.customMinScaleFactor)
                    }
//                    .frame(height: 100)
                    .background(Color.red)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Hello, world!")
        }
    }
}

extension DynamicTypeSize {
    var customMinScaleFactor: CGFloat {
        switch self {
        case .xSmall, .small, .medium:
            return 1.0
        case .large, .xLarge, .xxLarge:
            return 0.8
        default:
            return 0.85
        }
    }
}

struct AccessibilityTextBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityTextBootcamp()
    }
}
