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

    let onAddFood: (Food) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Add Food")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .center)

            VStack(spacing: 20) {
                TextField("Food", text: $name, axis: .vertical)
                    .keyboardType(.default)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(1...4)
                    .padding(.vertical, 8)

                HStack(spacing: 8) {
                    TextField("Calories", text: $calories)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .padding(.vertical, 8)
                        .onChange(of: calories) { _, newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            calories = filtered.first == "0" ? "" : filtered
                        }

                    Text("cal")
                        .font(.body.bold())
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 180)

            Button("Add") {
                if name == "" || calories == "" {
                    showMissingFieldsAlert = true
                    return
                }

                onAddFood(Food(name: name, calories: Int(calories)!))
                dismiss()
            }
            .font(.title3.bold())
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .glassEffect(.regular.tint(.red).interactive(), in: .rect(cornerRadius: 14))
            .padding(.top, 100)
        }
        .padding(.bottom, 120)
        .padding()
        .alert("Missing Fields!", isPresented: $showMissingFieldsAlert) {
            Button("Okay", role: .cancel) {}
        } message: {
            Text("Please complete all the fields to add food.")
        }
    }
}

#Preview {
    FoodEntryView { _ in }
}
