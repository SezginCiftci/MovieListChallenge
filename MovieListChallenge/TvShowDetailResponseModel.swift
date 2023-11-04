//
//  TvShowDetailResponseModel.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 4.11.2023.
//

import Foundation

// MARK: - TvShowDetailResponseModel
struct TvShowDetailResponseModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let homepage: String?
    let id: Int?
    let inProduction: Bool?
    let languages: [String]?
    let lastAirDate: String?
    let name: String?
    let numberOfEpisodes, numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let status, tagline, type: String?
    let voteAverage: Double?
    let voteCount: Int?
    var rating: String? {
        return "Show Rating: " + String(format: "%.1f", voteAverage ?? 0.0)
    }
    var posterURL: String? {
        return "https://image.tmdb.org/t/p/w500" + (posterPath ?? "")
    }
    var backdropURL: String? {
        return "https://image.tmdb.org/t/p/w500" + (backdropPath ?? "")
    }
    var homepageURL: URL? {
        return URL(string: homepage ?? "https://themoviedb.org/")
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case name
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
