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

    var body: some View {
        VStack(spacing: 28) {
            Text("Cudget")
                .font(.system(size: 44, weight: .black, design: .rounded))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)

            VStack(alignment: .leading, spacing: 12) {
                TextField("Food", text: $food)
                    .textFieldStyle(.roundedBorder)

                HStack(spacing: 8) {
                    TextField("Calories", text: $calories)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)

                    Text("cal")
                        .font(.body.bold())
                }
            }
            .frame(maxWidth: 280)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 72)
        .padding(.horizontal)
    }
}

#Preview {
    FoodEntryView()
}
