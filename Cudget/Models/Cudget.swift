//
//  Cudget.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/26/26.
//

import Foundation

struct Cudget: Codable, Equatable {
    public static var defaultCalories = 2000
    
    var sunday: Int = defaultCalories
    var monday: Int = defaultCalories
    var tuesday: Int = defaultCalories
    var wednesday: Int = defaultCalories
    var thursday: Int = defaultCalories
    var friday: Int = defaultCalories
    var saturday: Int = defaultCalories
}
