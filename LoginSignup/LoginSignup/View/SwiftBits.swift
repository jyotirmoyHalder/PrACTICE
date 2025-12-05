//
//  SwiftBits.swift
//  LoginSignup
//
//  Created by jyotirmoy_halder on 4/12/25.
//

import SwiftUI

struct SwiftBits: View {
    
    //Some mode
    enum PickerMode {
        case left, right
    }
    
    @State private var mode: PickerMode = .left
    
    var body: some View {
        
        VStack {
            //Button to toggle the mode
            Button {
                withAnimation {
                    mode = (mode != .left) ? .left : .right
                }
            } label: {
                Text("Change mode")
                    .font(.title)
            }
            //Picker to toggle the mode
            Picker("Picker", selection: $mode.animation(.default)) {
                Text("Left").tag(PickerMode.left)
                Text("Right").tag(PickerMode.right)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if mode == .left {
                Text("Left")
                    .transition(.opacity.combined(with: .scale))
            } else {
                Text("Right")
                    .transition(.opacity.combined(with: .scale))
            }
        }
        
    }
}

#Preview {
    SwiftBits()
}
