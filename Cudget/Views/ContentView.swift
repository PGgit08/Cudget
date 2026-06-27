//
//  ContentView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/25/26.
//

import SwiftUI

struct ContentView: View {
    @State private var cudget = Cudget()
    
    var body: some View {
        NavigationStack {
            MainView(cudget: $cudget)
        }
    }
}

#Preview {
    ContentView()
}
