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
    
    init() {
        genresRequest { response in
            switch response {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
}
