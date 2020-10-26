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
    @Request<DiscoverGenres>(url: "/discover/movie", urlParam: ["with_genres":"28"])
    var discoverRequest

    var didUpdateState: ((ListProcessingState, [Genre]?) -> Void)?
    var discovers: [[DiscoverResult]] = []
    
    init() {
        
    }
    
    func fetchGenres() {
        genresRequest { response in
            switch response {
            case .success(let result):
                print(result)
                if result.genres.isEmpty {
                    self.didUpdateState?(.empty, result.genres)
                } else {
                    result.genres.forEach { (genre) in
                        DispatchQueue.main.async {
//                            self.discoverRequest { response in
//                                switch response {
//                                case .success(let movies):
//                                    print(movies.results.count)
//                                    self.discovers.append(movies.results)
//                                case .failure(let error):
//                                    print(error.localizedDescription)
//                                }
//                            }
                            DispatchQueue.main.async {
                                print(self.discovers.count)
                                self.didUpdateState?(.success, result.genres)
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error)
                self.didUpdateState?(.retry, nil)
            }
        }
    }
}
