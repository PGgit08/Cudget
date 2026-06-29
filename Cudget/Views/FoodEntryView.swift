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
            .padding(.top, 260)

            Button {
                if name == "" || calories == "" {
                    showMissingFieldsAlert = true
                    return
                }

                onAddFood(Food(name: name, calories: Int(calories)!))
                dismiss()
            } label: {
                Text("Add")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .contentShape(Rectangle())
                    .glassEffect(.regular.tint(.red).interactive(), in: .rect(cornerRadius: 14))
            }
            .buttonStyle(.plain)
            .padding(.top, 140)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .overlay(alignment: .topLeading) {
            Image(systemName: "chevron.left")
                .font(.title3.bold())
                .foregroundStyle(.primary)
                .padding()
                .contentShape(Rectangle())
                .onTapGesture {
                    dismiss()
                }
        }
        .alert("Missing Fields!", isPresented: $showMissingFieldsAlert) {
            Button("Okay", role: .cancel) {}
        } message: {
            Text("Please complete all the fields to add food.")
        }
    }
}

#Preview {
    NavigationStack {
        FoodEntryView { _ in }
    }
}
