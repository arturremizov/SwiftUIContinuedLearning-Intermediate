//
//  MaskBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 8.10.22.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State var rating: Int = 0
    
    var body: some View {
        ZStack {
            startsView
                .overlay(overlayView.mask(startsView))
        }
    }
    
    private var startsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometryProxy in
            ZStack(alignment: .leading) {
                Rectangle()
//                    .foregroundColor(.yellow)
                    .fill(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(rating) / 5 * geometryProxy.size.width)
            }
        }
        .allowsHitTesting(false)
    }
}

struct MaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskBootcamp()
    }
}
