//
//  CalorieButtonView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/29/26.
//

import SwiftUI

struct CalorieButtonView: View {
    let activity: Bool

    var body: some View {
        Text(activity ? "Add Activity" : "Add Food")
            .font(.title3.bold())
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
            .glassEffect(.regular.tint(activity ? .green : .red).interactive(), in: .rect(cornerRadius: 14))
    }
}

#Preview {
    CalorieButtonView(activity: true)
        .padding()
}
