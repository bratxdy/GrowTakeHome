//
//  TasksViewModel.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import Foundation
import Resolver

class TasksViewModel: ObservableObject {
    enum State: Equatable {
        case initial, loading, loaded, error, empty
    }
    
    @Injected var tasksEndpoint: TasksAPI
    
    @Published var state: State
    @Published var tasks = [MyTask]() {
        didSet {
            firstIncompletdTask = tasks.first(where: { task in
                return task.completedDate == nil
            })
        }
    }
    @Published var destination: Destination?
    
    var firstIncompletdTask: MyTask?
    
    init(initialState: State, tasks: [MyTask] = [MyTask]()) {
        self.state = initialState
        self.tasks = tasks
    }
    
    @MainActor
    func loadTasks() async {
        state = .loading
        
        do {
            let tasks = try await tasksEndpoint.getTasks()
            if tasks.isEmpty {
                state = .empty
            } else {
                self.tasks = tasks
                self.state = .loaded
            }
        } catch {
            print(error.localizedDescription)
            state = .error
        }
    }
    
    func getTaskCellState(for task: MyTask) -> TaskCell.State {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        
        if let completedDate = task.completedDate {
            return .completed(mood: task.moodChoice?.capitalized ?? "Completed: \(dateFormatter.string(from: completedDate))")
        } else if task.unlockedDate < Date.now {
            if task == firstIncompletdTask {
                return .unlocked(dateString: dateFormatter.string(from: task.unlockedDate))
            } else {
                return .locked(dateString: dateFormatter.string(from: task.unlockedDate))
            }
        } else {
            return .locked(dateString: dateFormatter.string(from: task.unlockedDate))
        }
    }
    
    func completeTask(index: Int, task: MyTask) {
        tasks[index] = task
    }
}
