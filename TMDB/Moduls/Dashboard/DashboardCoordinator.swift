//
//  DashboardCoordinator.swift
//  TMDB
//
//  Created by TMLI IT DEV on 25/10/20.
//

import UIKit

class DashboardCoordinator: BaseCoordinator {
    var navigationController: UINavigationController?
    
    init(navigationController :UINavigationController?) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewController = DashboardViewController()
        let viewModel = DashboardVM()
        
        viewController.viewModel = viewModel
        viewModel.didTapToDiscover = { genre in
            self.presentDiscover(genre: genre)
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentDiscover(genre: Genre) {
        let coordinator = DiscoverCoordinator(navigationController: navigationController, and: genre)
        
        // store child coordinator
        self.store(coordinator: coordinator)
        coordinator.start()
        
        // detect when free it
        coordinator.isCompleted = { [weak self] in
            self?.free(coordinator: coordinator)
        }
    }
}
