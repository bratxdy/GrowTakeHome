//
//  Task.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import Foundation

struct MyTask: Codable, Hashable {
    let numberOfBreaths: Int
    let moodChoices: [String]
    let unlockedDate: Date
    var completedDate: Date?
    var moodChoice: String?
}
