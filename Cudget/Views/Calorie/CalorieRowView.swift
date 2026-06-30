//
//  CalorieRowView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/26/26.
//

import SwiftUI

struct CalorieRowView: View {
    let name: String
    let calories: Int

    var body: some View {
        HStack {
            Text(name)
                .font(.headline)
                .lineLimit(1)
                .truncationMode(.tail)

            Spacer()

            Text("\(calories) cal")
                .font(.headline)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .layoutPriority(1)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.24))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    CalorieRowView(name: "Very Long Name That Should Trail Off", calories: 950)
        .padding()
}
