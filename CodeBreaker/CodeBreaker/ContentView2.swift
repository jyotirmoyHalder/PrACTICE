//
//  ContentView2.swift
//  CodeBreaker
//
//  Created by jyotirmoy_halder on 27/1/26.
//

import SwiftUI

struct ContentView2: View {
    var body: some View {
        VStack {
            pegs(colors: [.red, .green, .green, .blue])
            pegs(colors: [.red, .blue, .green, .red])
            pegs(colors: [.red, .yellow, .green, .blue])
        }
        .padding()
    }
    
    func pegs(colors: Array<Color>) -> some View {
        HStack {
            ForEach(colors.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(colors[index])
            }
            MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
        }
    }
}

#Preview {
    ContentView2()
}
