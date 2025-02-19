//
//  SessionEndpoint.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import Foundation

class SessionEndpoint: SessionAPI {
    func isProviderAvailable() async throws -> Bool {
        try await Task.sleep(for: .seconds(1))
        return false
    }
    
    func waitForProvider() async throws -> Bool {
        try await Task.sleep(for: .seconds(10))
        return true
    }
}
