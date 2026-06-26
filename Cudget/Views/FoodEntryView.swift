//
//  FoodEntryView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/25/26.
//

import SwiftUI

// TODO: fix this entire view's UI!! it's trash!!

struct FoodEntryView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var calories = ""
    
    @State private var showMissingFieldsAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Cudget")
                .font(.system(size: 84, weight: .black, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 130)

            TextField("Food", text: $name, axis: .vertical)
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
                    if name == "" || calories == "" {
                        showMissingFieldsAlert = true
                    }
                }
                .frame(maxWidth: .infinity)

                Button("Cancel") {
                    dismiss()
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.top, 140)
            .buttonStyle(.glass)
        }
        .padding(.bottom, 120)
        .padding()
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $showMissingFieldsAlert) {
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
