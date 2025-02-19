//
//  SessionCoordinatorViewModel.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import Resolver
import SwiftUI

class SessionCoordinatorViewModel: ObservableObject {
    enum Constants {
        static let inhaleExhaleDuration: TimeInterval = 8
    }
    
    enum State: Equatable {
        case initial, loading, breathWork, waiting, session, moodSelection
    }
    
    @Injected var sessionEndpoint: SessionAPI
    
    @Published var state: State
    @Published var isAvailable: Bool
    var task: Binding<MyTask>
    @Published var numberOfBreaths: Int
    
    lazy var timer = Timer.publish(every: Constants.inhaleExhaleDuration, on: .main, in: .common).autoconnect()
    
    init(initialState: State, isAvailable: Bool = false, task: Binding<MyTask>) {
        self.state = initialState
        self.isAvailable = isAvailable
        self.task = task
        self.numberOfBreaths = task.wrappedValue.numberOfBreaths
    }
    
    @MainActor
    func loadProviderStatus() async {
        state = .loading
                
        do {
            isAvailable = try await sessionEndpoint.isProviderAvailable()
            
            if isAvailable {
                withAnimation {
                    state = .waiting
                }
            } else {
                withAnimation {
                    state = .breathWork
                }
                await waitForProvider()
            }
        } catch {
            withAnimation {
                state = .breathWork
            }
            await waitForProvider()
        }
    }
    
    @MainActor
    func waitForProvider() async {
        do {
            let isAvailable = try await sessionEndpoint.waitForProvider()
            withAnimation {
                self.isAvailable = isAvailable
            }
            
            if !isAvailable {
                print("timed out")
            }
        } catch {
            print("An error occurred")
        }
    }
}
