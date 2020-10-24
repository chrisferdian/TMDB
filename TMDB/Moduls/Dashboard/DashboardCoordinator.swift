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
//        viewModel.didTapToDetail = { element in
//            self.navigateToDetail(element: element)
//        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
