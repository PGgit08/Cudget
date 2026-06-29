//
//  ContentView.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/25/26.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase

    @State private var cudget = CudgetStorage.loadCudget()
    @State private var foods = CudgetStorage.loadFoods()
    
    var body: some View {
        NavigationStack {
            MainView(cudget: $cudget, foods: $foods)
        }
        .background(KeyboardDismissView())
        .onAppear {
            clearFoodsIfNeeded()
        }
        .onChange(of: scenePhase) { _, newValue in
            if newValue == .active {
                clearFoodsIfNeeded()
            }
        }
        .onChange(of: cudget) { _, newValue in
            CudgetStorage.saveCudget(newValue)
        }
        .onChange(of: foods) { _, newValue in
            CudgetStorage.saveFoods(newValue)
        }
        .task {
            await clearFoodsAtMidnight()
        }
    }

    private func clearFoodsIfNeeded() {
        if CudgetStorage.shouldClearFoodsForToday() {
            foods = []
            CudgetStorage.saveFoods([])
        }
    }

    private func clearFoodsAtMidnight() async {
        while !Task.isCancelled {
            let now = Date()
            let nextMidnight = Calendar.current.nextDate(
                after: now,
                matching: DateComponents(hour: 0, minute: 0, second: 0),
                matchingPolicy: .nextTime
            ) ?? now.addingTimeInterval(86_400)
            let secondsUntilMidnight = max(nextMidnight.timeIntervalSince(now), 1)

            try? await Task.sleep(for: .seconds(secondsUntilMidnight))

            if !Task.isCancelled {
                clearFoodsIfNeeded()
            }
        }
    }
}

private enum CudgetStorage {
    private static let cudgetKey = "savedCudget"
    private static let foodsKey = "savedFoods"
    private static let foodsSavedDateKey = "foodsSavedDate"

    static func loadCudget() -> Cudget {
        guard let data = UserDefaults.standard.data(forKey: cudgetKey),
              let cudget = try? JSONDecoder().decode(Cudget.self, from: data) else {
            return Cudget()
        }

        return cudget
    }

    static func saveCudget(_ cudget: Cudget) {
        guard let data = try? JSONEncoder().encode(cudget) else { return }
        UserDefaults.standard.set(data, forKey: cudgetKey)
    }

    static func loadFoods() -> [Food] {
        if shouldClearFoodsForToday() {
            saveFoods([])
            return []
        }

        guard let data = UserDefaults.standard.data(forKey: foodsKey),
              let foods = try? JSONDecoder().decode([Food].self, from: data) else {
            return []
        }

        return foods
    }

    static func saveFoods(_ foods: [Food]) {
        guard let data = try? JSONEncoder().encode(foods) else { return }
        UserDefaults.standard.set(data, forKey: foodsKey)
        UserDefaults.standard.set(Date(), forKey: foodsSavedDateKey)
    }

    static func shouldClearFoodsForToday() -> Bool {
        guard let savedDate = UserDefaults.standard.object(forKey: foodsSavedDateKey) as? Date else {
            return false
        }

        return !Calendar.current.isDateInToday(savedDate)
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
