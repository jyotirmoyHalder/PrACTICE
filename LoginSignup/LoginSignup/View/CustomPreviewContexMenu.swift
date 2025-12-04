//
//  CustomPreviewContexMenu.swift
//  LoginSignup
//
//  Created by jyotirmoy_halder on 4/12/25.
//

import SwiftUI

struct CustomPreviewContexMenu: View {
    var body: some View {
        Text("Your Invoice for December")
            .contextMenu {
                Button("Reply", systemImage: "arrow.turn.up.left") {}
                Button("Mark as Read", systemImage: "envelope.open") {}
                Button("Delete", systemImage: "trash", role: .destructive) {}
            }preview: {
                VStack(alignment: .leading) {
                    Text("Your Invoice for December")
                        .font(.headline)
                    Text("Hi there,\n Here's your invoice for this month.\nThanks!")
                        .font(.subheadline).foregroundStyle(.secondary)
                }
                .padding(20)
            }
    }
}

#Preview {
    CustomPreviewContexMenu()
}
