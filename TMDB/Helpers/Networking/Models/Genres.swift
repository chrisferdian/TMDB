//
//  Genres.swift
//  TMDB
//
//  Created by TMLI IT DEV on 25/10/20.
//

import Foundation

struct ResponseGenres: BaseResponse {
    var status_code: Int?
    var status_message: String?
    var success: Bool?
    let genres: [Genre]
}
// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

protocol BaseResponse: Codable {
    var status_code: Int? { get set }
    var status_message: String? { get set }
    var success: Bool? { get set }
}
