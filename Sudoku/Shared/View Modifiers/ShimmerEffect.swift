//
//  ShimmerEffect.swift
//  Sudoku
//
//  Created by Ray Kim on 12/31/24.
//  Copyright © 2024 Self. All rights reserved.
//

import SwiftUI

struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .mask {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .clear, location: 0),
                                .init(color: .black.opacity(0.5), location: 0.45),
                                .init(color: .black.opacity(0.5), location: 0.55),
                                .init(color: .clear, location: 1)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .offset(x: -100)
                    .offset(x: phase)
            }
            .onAppear {
                withAnimation(.linear(duration: 3).delay(0.25).repeatForever(autoreverses: false)) {
                    phase = 400
                }
            }
    }
}
