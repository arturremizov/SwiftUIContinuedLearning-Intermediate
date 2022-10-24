//
//  GeometryReaderBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 7.10.22.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometryProxy in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometryProxy) * 40),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
//        GeometryReader { geometryProxy in
//            HStack(spacing: 0.0) {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: geometryProxy.size.width * 0.666)
//
//                Rectangle().fill(.blue)
//            }
//            .ignoresSafeArea()
//        }
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return (1 - (currentX / maxDistance))
    }
}

struct GeometryReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootcamp()
    }
}
