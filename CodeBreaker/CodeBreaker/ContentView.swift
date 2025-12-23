//
//  ContentView.swift
//  CodeBreaker
//
//  Created by jyotirmoy_halder on 23/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            greetings()
        }
        .padding()
    }
    
    @ViewBuilder
    func greetings() -> TupleView<(Image, Text, Circle)> {
        Image(systemName: "globe")
        Text("Greetings!")
        Circle()
    }
}

#Preview {
    ContentView()
}
