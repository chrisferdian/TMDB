//
//  DashboardVM.swift
//  TMDB
//
//  Created by TMLI IT DEV on 25/10/20.
//

import Foundation

class DashboardVM {
    @Request<ResponseGenres>(url: "/genre/movie/list")
    var genresRequest
    
    var didUpdateState: ((ListProcessingState, [Genre]?) -> Void)?
    var didTapToDiscover: ((Genre) -> Void)?

    init() {}
    
    func fetchGenres() {
        genresRequest { response in
            switch response {
            case .success(let result):
                print(result)
                if result.genres.isEmpty {
                    self.didUpdateState?(.empty, result.genres)
                } else {
                    DispatchQueue.main.async {
                        self.didUpdateState?(.success, result.genres)
                    }
                }
            case .failure(let error):
                print(error)
                self.didUpdateState?(.retry, nil)
            }
        }
    }
}
