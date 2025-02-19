//
//  GrowTakeHomeApp.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import SwiftUI

@main
struct GrowTakeHomeApp: App {
    var body: some Scene {
        WindowGroup {
            TasksView(viewModel: TasksViewModel(initialState: .initial))
        }
    }
}
