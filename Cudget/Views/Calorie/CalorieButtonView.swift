//
//  CalorieButtonView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/29/26.
//

import SwiftUI

struct CalorieButtonView: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.title3.bold())
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
            .glassEffect(.regular.tint(color).interactive(), in: .rect(cornerRadius: 14))
    }
}

#Preview {
    CalorieButtonView(text: "Add Calorie", color: .red)
        .padding()
}
