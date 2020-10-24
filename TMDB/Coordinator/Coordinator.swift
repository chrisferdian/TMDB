//
//  Coordinator.swift
//  TMDB
//
//  Created by TMLI IT DEV on 24/10/20.
//

import Foundation
protocol Coordinator : class {
    var childCoordinators : [Coordinator] { get set }
    func start()
}
extension Coordinator {

    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
