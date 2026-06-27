//
//  Weekday.swift
//  Cudget
//
//  Created by Peter Gutkovich on 6/26/26.
//

import Foundation

enum Weekday: Hashable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    public static func today(using calendar: Calendar = .current) -> Weekday {
        switch calendar.component(.weekday, from: Date()) {
            case 1:
                return .sunday
            case 2:
                return .monday
            case 3:
                return .tuesday
            case 4:
                return .wednesday
            case 5:
                return .thursday
            case 6:
                return .friday
            default:
                return .saturday
        }
    }

    public func getCalories(from cudget: Cudget) -> Int {
        switch self {
            case .sunday:
                cudget.sunday
            case .monday:
                cudget.monday
            case .tuesday:
                cudget.tuesday
            case .wednesday:
                cudget.wednesday
            case .thursday:
                cudget.thursday
            case .friday:
                cudget.friday
            case .saturday:
                cudget.saturday
        }
    }
}
