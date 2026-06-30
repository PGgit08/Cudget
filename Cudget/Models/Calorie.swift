//
//  Calorie.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/26/26.
//

import Foundation

struct Calorie: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let calories: Int

    init(id: UUID = UUID(), name: String, calories: Int) {
        self.id = id
        self.name = name
        self.calories = calories
    }
}
