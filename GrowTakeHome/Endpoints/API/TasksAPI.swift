//
//  TasksAPI.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import Foundation

protocol TasksAPI {
    func getTasks() async throws -> [MyTask]
}
