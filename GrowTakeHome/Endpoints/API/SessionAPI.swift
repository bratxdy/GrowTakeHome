//
//  SessionAPI.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import Foundation

protocol SessionAPI {
    func isProviderAvailable() async throws -> Bool
    func waitForProvider() async throws -> Bool
}
