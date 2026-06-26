//
//  CudgetHeadingView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/26/26.
//

import SwiftUI

struct CudgetHeadingView: View {
    var body: some View {
        VStack(spacing: 1) {
            HStack {
                NavigationLink {
                    CudgetView()
                } label: {
                    Text("Cudget 🗓️")
                        .font(.title2)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                Spacer()

                NavigationLink {
                    HistoryView()
                } label: {
                    Text("History 📈")
                        .font(.title2)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 20)

            Text("Cudget")
                .font(.system(size: 84, weight: .black, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    NavigationStack {
        CudgetHeadingView()
    }
}
