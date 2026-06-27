//
//  CudgetView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/26/26.
//

import SwiftUI

struct CudgetView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var cudget: Cudget

    @State private var sunday: String
    @State private var monday: String
    @State private var tuesday: String
    @State private var wednesday: String
    @State private var thursday: String
    @State private var friday: String
    @State private var saturday: String

    init(cudget: Binding<Cudget>) {
        self._cudget = cudget
        self._sunday = State(initialValue: String(cudget.wrappedValue.sunday))
        self._monday = State(initialValue: String(cudget.wrappedValue.monday))
        self._tuesday = State(initialValue: String(cudget.wrappedValue.tuesday))
        self._wednesday = State(initialValue: String(cudget.wrappedValue.wednesday))
        self._thursday = State(initialValue: String(cudget.wrappedValue.thursday))
        self._friday = State(initialValue: String(cudget.wrappedValue.friday))
        self._saturday = State(initialValue: String(cudget.wrappedValue.saturday))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            calorieRow(day: "Sunday", calories: $sunday, weekday: .sunday)
            calorieRow(day: "Monday", calories: $monday, weekday: .monday)
            calorieRow(day: "Tuesday", calories: $tuesday, weekday: .tuesday)
            calorieRow(day: "Wednesday", calories: $wednesday, weekday: .wednesday)
            calorieRow(day: "Thursday", calories: $thursday, weekday: .thursday)
            calorieRow(day: "Friday", calories: $friday, weekday: .friday)
            calorieRow(day: "Saturday", calories: $saturday, weekday: .saturday)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3.bold())
                    .padding()
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }

    private func calorieRow(day: String, calories: Binding<String>, weekday: Weekday) -> some View {
        HStack(spacing: 8) {
            Text("\(day):")
                .font(.headline)
                .frame(width: 105, alignment: .leading)

            TextField("", text: calories)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .onChange(of: calories.wrappedValue) { _, newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    let displayValue = filtered.first == "0" ? "" : filtered

                    if displayValue != newValue {
                        calories.wrappedValue = displayValue
                    }

                    updateCudget(weekday, calories: Int(displayValue) ?? 0)
                }

            Text("cal")
                .font(.body.bold())
        }
    }

    private func updateCudget(_ weekday: Weekday, calories: Int) {
        switch weekday {
            case .sunday:
                cudget.sunday = calories
            case .monday:
                cudget.monday = calories
            case .tuesday:
                cudget.tuesday = calories
            case .wednesday:
                cudget.wednesday = calories
            case .thursday:
                cudget.thursday = calories
            case .friday:
                cudget.friday = calories
            case .saturday:
                cudget.saturday = calories
        }
    }
}

#Preview {
    NavigationStack {
        CudgetView(cudget: .constant(Cudget()))
    }
}
