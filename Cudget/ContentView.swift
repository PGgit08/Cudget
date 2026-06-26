//
//  ContentView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/25/26.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("Enter a Number")
                .font(.title2)
                .fontWeight(.semibold)

            TextField("0", text: $amount)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .font(.title)
                .frame(maxWidth: 220)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
