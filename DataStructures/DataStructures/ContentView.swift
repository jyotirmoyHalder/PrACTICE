//
//  ContentView.swift
//  DataStructures
//
//  Created by jyotirmoy_halder on 10/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(){
            printWeightedGraph()
            print("break")
            demoDijkstra()
        }
    }
}

#Preview {
    ContentView()
}
