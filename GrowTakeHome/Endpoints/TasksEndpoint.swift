//
//  TasksEndpoint.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import Foundation

class TasksEndpoint: TasksAPI {
    func getTasks() async throws -> [MyTask] {
        let tasks = try JSONLoader().loadJSONFile(named: "myTasks", type: MyTasks.self).tasks
        try await Task.sleep(for: .seconds(1))
        return tasks
    }
}
