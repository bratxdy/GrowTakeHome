//
//  Resolver.swift
//  GrowTakeHome
//
//  Created by Brady Miller on 2/19/25.
//

import Resolver

extension Resolver: @retroactive ResolverRegistering {
    public static func registerAllServices() {
        register { SessionEndpoint() }
            .implements(SessionAPI.self)
        
        register { TasksEndpoint() }
            .implements(TasksAPI.self)
    }
}
