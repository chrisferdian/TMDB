//
//  ResponseReviews.swift
//  TMDB
//
//  Created by TMLI IT DEV on 27/10/20.
//

import Foundation
// MARK: - ResponseReviews
struct ResponseReviews: Codable {
    let id, page: Int
    let results: [ResultReview]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
// MARK: - Result
struct ResultReview: Codable {
    let author, content, id: String
    let url: String
}
