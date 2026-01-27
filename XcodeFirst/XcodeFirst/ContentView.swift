//
//  ContentView.swift
//  XcodeFirst
//
//  Created by jyotirmoy_halder on 26/1/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Background Color
            LinearGradient(
                colors: [
                    Color.blue, Color.cyan.opacity(0.5), Color.indigo
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
                .ignoresSafeArea()
            VStack {
                Image(systemName: "person.fill")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Welcome To iOS Development")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("First App")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.blue.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text("I love to Code!")
                Text("Please feel free to ask questions, send requests via the course Q&A or diret message me.")
                    .bold()
                    .foregroundStyle(.red)
                    .padding()
                    .multilineTextAlignment(.trailing)
                
                Image(.sunsetPhoto)
                    .resizable()
                    .frame(height: 200)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
