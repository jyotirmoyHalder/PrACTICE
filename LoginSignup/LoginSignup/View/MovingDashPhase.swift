//
//  MovingDashPhase.swift
//  LoginSignup
//
//  Created by jyotirmoy_halder on 5/12/25.
//

import SwiftUI

struct MovingDashPhase: View {
    
    var body: some View {
        PhaseAnimator([false, true]) { move in
            Button {
                //
            } label: {
                ZStack {
                    Rectangle()
                        .clipShape(.rect(cornerRadius: 27))
                        .frame(width: 160, height: 54)
                        .foregroundStyle(.indigo.gradient)
                    
                    RoundedRectangle(cornerRadius: 27)
                        .stroke(
                            style: StrokeStyle(
                                lineWidth: 8,
                                lineCap: .round,
                                lineJoin: .round,
                                dash: [40, 400],
                                dashPhase: move ? 220 : -220)
                        )
                        .frame(width: 160, height: 54)
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [.indigo, .white, .purple, .mint, .white, .orange, .indigo]), startPoint: .trailing, endPoint: .leading)
                        )
                        .shadow(radius: 2)
                    
                    HStack {
                        Text("Live Now")
                        Image(systemName: "arrow.right")
                    }
                    .bold()
                }
                
            }
            .tint(move ? .orange : .white)
            .glassEffect()
            
            
        } animation: { move in
                .easeOut.speed(0.1).repeatForever(autoreverses: false)
        }
    }
}

#Preview {
    MovingDashPhase()
        .preferredColorScheme(.light)
}
