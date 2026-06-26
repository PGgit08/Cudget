//
//  Food.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/26/26.
//

import Foundation

struct Food: Identifiable {
    let id = UUID()
    let name: String
    let calories: Int
}
