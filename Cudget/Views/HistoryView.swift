//
//  HistoryView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/26/26.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Text("History")
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
}

#Preview {
    NavigationStack {
        HistoryView()
    }
}
