//
//  AppCoordinator.swift
//  TMDB
//
//  Created by TMLI IT DEV on 25/10/20.
//

import UIKit

class AppCoordinator : BaseCoordinator {

    let window : UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start() {
        // preparing root view
        let navigationController = UINavigationController()
        let myCoordinator = DashboardCoordinator(navigationController: navigationController)
        
        // store child coordinator
        self.store(coordinator: myCoordinator)
        myCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        // detect when free it
        myCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: myCoordinator)
        }
    }
}
