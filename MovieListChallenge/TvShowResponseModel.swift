//
//  TvShowResponseModel.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 3.11.2023.
//

import Foundation

struct TvShowResponseModel: Codable {
    let page: Int?
    let results: [TvResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - TvResult
struct TvResult: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originCountry: [String]?
    let overview: String?
    let popularity: Double?
    let posterPath, firstAirDate, name: String?
    let voteAverage: Double?
    let voteCount: Int?
    var rating: String? {
        return "Show Rating: " + String(format: "%.1f", voteAverage ?? 0.0)
    }
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500" + (posterPath ?? ""))
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originCountry = "origin_country"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
