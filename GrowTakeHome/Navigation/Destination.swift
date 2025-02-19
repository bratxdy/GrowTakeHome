//
//  Destination.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import SwiftUI

enum Destination: Equatable, Identifiable {
    var id: String {
        return String(reflecting: self)
    }
    
    static func ==(lhs: Destination, rhs: Destination) -> Bool {
        lhs.id == rhs.id
    }
    
    case sessionCoordinator(task: Binding<MyTask>)
}
