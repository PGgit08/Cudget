//
//  FoodEntryView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/25/26.
//

import SwiftUI

struct FoodEntryView: View {
    @State private var food = ""
    @State private var calories = ""
    
    @State private var showAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Cudget")
                .font(.system(size: 84, weight: .black, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 130)

            TextField("Food", text: $food, axis: .vertical)
                .keyboardType(.default)
                .textFieldStyle(.roundedBorder)
                .lineLimit(1...4)

            HStack(spacing: 8) {
                TextField("Calories", text: $calories)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: calories) { _, newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        calories = filtered.first == "0" ? "" : filtered
                    }

                Text("cal")
                    .font(.body.bold())
            }

            HStack(spacing: 8) {
                Button("Add") {
                    if food == "" || calories == "" {
                        showAlert = true
                    }
                }
                .frame(maxWidth: .infinity)

                Button("Cancel") {}
                .frame(maxWidth: .infinity)
            }
            .padding(.top, 140)
            .buttonStyle(.glass)
        }
        // TODO: fix shitty padding
        .padding(.bottom, 120)
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Missing fields"),
                message: Text("Please complete all fields to add food")
            )
        }
    }
}

#Preview {
    FoodEntryView()
}
