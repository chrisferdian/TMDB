//
//  DetailCoordinator.swift
//  TMDB
//
//  Created by TMLI IT DEV on 26/10/20.
//

import UIKit
import AVKit

class DetailCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController?
    var discover: DiscoverResult?
    
    init(navigationController :UINavigationController?, and discover: DiscoverResult) {
        self.navigationController = navigationController
        self.discover = discover
    }
    
    override func start() {
        let vc = DetailViewController()
        let vm = DetailVM(discover: discover!)
        vm.didGetVideoSuccess = { key in
            let url = "https://youtu.be/" + key
            self.presentVideoPlayer(into: url)
        }
        navigationController?.pushViewController(vc, animated: true)
        
        vc.viewModel = vm
    }
    
    private func presentVideoPlayer(into url: String) {
        guard let url = URL(string: url) else {
          return //be safe
        }
        DispatchQueue.main.async {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}

