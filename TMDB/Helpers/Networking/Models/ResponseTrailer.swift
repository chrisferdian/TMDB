//
//  ResponseTrailer.swift
//  TMDB
//
//  Created by TMLI IT DEV on 26/10/20.
//

import Foundation
// MARK: - ResponseTrailer
struct ResponseTrailer: BaseResponse {
    var status_code: Int?
    var status_message: String?
    var success: Bool?
    let id: Int
    let results: [TrailerResult]
}

// MARK: - Result
struct TrailerResult: Codable {
    let id, iso639_1, iso3166_1, key: String
    let name, site: String
    let size: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}
