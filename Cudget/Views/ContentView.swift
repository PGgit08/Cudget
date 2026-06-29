//
//  ContentView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/25/26.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var cudget = Cudget()
    
    var body: some View {
        NavigationStack {
            MainView(cudget: $cudget)
        }
        .background(KeyboardDismissView())
    }
}

private struct KeyboardDismissView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = false
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            context.coordinator.attach(to: uiView.window)
        }
    }

    final class Coordinator: NSObject, UIGestureRecognizerDelegate {
        private weak var window: UIWindow?
        private var tapGesture: UITapGestureRecognizer?

        func attach(to window: UIWindow?) {
            guard let window else { return }
            guard self.window !== window else { return }

            if let tapGesture {
                self.window?.removeGestureRecognizer(tapGesture)
            }

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapGesture.cancelsTouchesInView = false
            tapGesture.delegate = self

            window.addGestureRecognizer(tapGesture)
            self.window = window
            self.tapGesture = tapGesture
        }

        @objc private func dismissKeyboard() {
            window?.endEditing(true)
        }

        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            var view = touch.view

            while let currentView = view {
                if currentView is UITextField || currentView is UITextView {
                    return false
                }

                view = currentView.superview
            }

            return true
        }

        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            true
        }
    }
}

#Preview {
    ContentView()
}
