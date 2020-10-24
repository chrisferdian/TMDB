//
//  BaseCoordinator.swift
//  TMDB
//
//  Created by TMLI IT DEV on 24/10/20.
//

import Foundation

internal class BaseCoordinator : Coordinator {
    var childCoordinators : [Coordinator] = []
    var isCompleted: (() -> ())?

    func start() {
        fatalError("Children should implement `start`.")
    }
}
