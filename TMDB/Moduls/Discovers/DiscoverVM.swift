//
//  DiscoverVM.swift
//  TMDB
//
//  Created by TMLI IT DEV on 26/10/20.
//

import Foundation

class DiscoverVM {
    
    @Request<DiscoverGenres>(url: "/discover/movie", urlParam: ["with_genres":"28"])
    var discoverRequest
    var didUpdateState: ((ListProcessingState, [DiscoverResult]?) -> Void)?
    var didTapToDetail: ((DiscoverResult) -> Void)?

    var genre: Genre?
    var page: Int = 1
    var totalPage = 0
    
    init(genre: Genre) {
        self.genre = genre
        fetchDiscovers()
    }
    
    func fetchDiscovers() {
        self._discoverRequest.setParameters(body: ["with_genres": String(genre!.id), "page": "\(page)"])
        self.discoverRequest { response in
            switch response {
            case .success(let movies):
                self.totalPage = movies.totalPages
                if self.page < self.totalPage {
                    self.didUpdateState?(.success, movies.results)
                    self.page += 1
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
