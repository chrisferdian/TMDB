//
//  DetailVM.swift
//  TMDB
//
//  Created by TMLI IT DEV on 26/10/20.
//

import Foundation

class DetailVM {
    
    @Request<ResponseDetail>(url: "/movie")
    var discoverRequest
    @Request<ResponseTrailer>(url: "/movie")
    var trailerRequest
    @Request<ResponseReviews>(url: "/movie")
    var reviewsRequest
    
    var discover: DiscoverResult?
    var didGetDetailSuccess: ((ResponseDetail) -> Void)?
    var didGetVideoSuccess: ((String) -> Void)?
    var didGetReviewsSuccess: ((ResponseReviews) -> Void)?

    init(discover: DiscoverResult) {
        self.discover = discover
        _discoverRequest.addUrlComponent(component: String(discover.id ?? 0))
        _trailerRequest.addUrlComponent(component: String(discover.id ?? 0))
        _trailerRequest.addUrlComponent(component: "videos")
        
        _reviewsRequest.addUrlComponent(component: String(discover.id ?? 0))
        _reviewsRequest.addUrlComponent(component: "reviews")
        
        discoverRequest { response in
            switch response {
            case .success(let result):
                self.didGetDetailSuccess?(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func getReviews() {
        reviewsRequest { res in
            switch res {
            case .success(let result):
                self.didGetReviewsSuccess?(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func getVideos() {
        trailerRequest { response in
            switch response {
            case .success(let result):
                self.didGetVideoSuccess?(result.results.first?.key ?? "")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
