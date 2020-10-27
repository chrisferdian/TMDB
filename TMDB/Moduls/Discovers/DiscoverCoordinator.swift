//
//  DiscoverCoordinator.swift
//  TMDB
//
//  Created by TMLI IT DEV on 26/10/20.
//

import UIKit

class DiscoverCoordinator: BaseCoordinator {
    var navigationController: UINavigationController?
    var genre: Genre?
    
    init(navigationController :UINavigationController?, and genre: Genre) {
        self.navigationController = navigationController
        self.genre = genre
    }
    
    override func start() {
        let vc = DiscoverViewController()
        guard let genre = genre else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
        let vm = DiscoverVM(genre: genre)
        
        vc.viewModel = vm
        vm.didTapToDetail = { discover in
            self.navigateToDetail(with: discover)
        }
    }
    
    private func navigateToDetail(with discover: DiscoverResult) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, and: discover)
        
        self.store(coordinator: detailCoordinator)
        detailCoordinator.start()
        // detect when free it
        detailCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: detailCoordinator)
        }
    }
}
