//
//  TasksView.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import SwiftUI

struct TasksView: View {
    @StateObject var viewModel: TasksViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .initial, .loading:
                makeLoadingState()
            case .loaded:
                makeLoadedState()
            case .empty:
                makeEmptyState()
            case .error:
                makeErrorState()
            }
        }
        .fullScreenCover(item: $viewModel.destination) { destination in
            switch destination {
            case .sessionCoordinator(let task):
                SessionCoordinatorView(viewModel: SessionCoordinatorViewModel(initialState: .initial, task: task))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.beige)
        .task {
            guard viewModel.state == .initial else { return }
            await viewModel.loadTasks()
        }
    }
    
    @ViewBuilder func makeLoadingState() -> some View {
        VStack {
            Spacer()
            
            ProgressView()
            
            Spacer()
        }
    }
    
    @ViewBuilder func makeLoadedState() -> some View {
        VStack(spacing: 0) {
            Text("My Tasks")
                .font(.system(size: 34, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach((0..<viewModel.tasks.count).reversed(), id: \.self) { i in
                        let task = viewModel.tasks[i]
                        TaskCell(state: viewModel.getTaskCellState(for: task)) {
                            let taskBinding = Binding {
                                viewModel.tasks[i]
                            } set: { task in
                                viewModel.completeTask(index: i, task: task)
                            }

                            viewModel.destination = .sessionCoordinator(task: taskBinding)
                        }
                    }
                }
                .padding(8)
            }
            .padding(.top, 36)
        }
        .padding(24)
    }
    
    @ViewBuilder func makeEmptyState() -> some View {
        VStack {
            Image(systemName: "exclamationmark.circle")
                .resizable()
                .frame(width: 132, height: 132)
                .padding(.top, 128)
            
            Text("There are no tasks")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 24)
            
            Spacer()
            
            Button {
                Task { await viewModel.loadTasks() }
            } label: {
                Text("Try Again")
            }
            .padding(.bottom, 48)
        }
    }
    
    @ViewBuilder func makeErrorState() -> some View {
        VStack {
            Image(systemName: "exclamationmark.circle")
                .resizable()
                .frame(width: 132, height: 132)
                .padding(.top, 128)
            
            Text("An Error Occurred")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 24)
            
            Spacer()
            
            Button {
                Task { await viewModel.loadTasks() }
            } label: {
                Text("Try Again")
            }
            .padding(.bottom, 48)
        }
    }
}
#Preview("Loading State") {
    TasksView(viewModel: TasksViewModel(initialState: .loading))
}

#Preview("Loaded State") {
    TasksView(viewModel: TasksViewModel(initialState: .loaded, tasks: try! JSONLoader().loadJSONFile(named: "myTasks", type: MyTasks.self).tasks))
}

#Preview("Empty State") {
    TasksView(viewModel: TasksViewModel(initialState: .empty))
}

#Preview("Error State") {
    TasksView(viewModel: TasksViewModel(initialState: .error))
}
