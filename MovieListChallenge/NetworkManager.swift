//
//  NetworkManager.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 3.11.2023.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
  func getPopularMovies(pageIndex: Int, completion: @escaping (Result<TvShowResponseModel, AFError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
  func getPopularMovies(pageIndex: Int, completion: @escaping (Result<TvShowResponseModel, AFError>) -> Void) {
    request(method: .popular(pageIndex: pageIndex), completion: completion)
  }
}

//MARK: General Usage
extension NetworkManager {
  private func request<T:Decodable>(method: APIMethods, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) {
    AF.request(method)
      .responseDecodable(decoder: decoder) { (response: DataResponse<T, AFError>) in
        completion(response.result)
      }
  }
}



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

// MARK: - Result
struct TvResult: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originCountry: [String]?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath, firstAirDate, name: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
