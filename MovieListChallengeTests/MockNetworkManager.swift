//
//  MockNetworkManager.swift
//  MovieListChallengeTests
//
//  Created by Sezgin Çiftci on 6.11.2023.
//

import Foundation
import Alamofire
@testable import MovieListChallenge

final class MockNetworkManager: NetworkManagerInterface {
    
    var invokeGetPopularShows = false
    var invokeGetPopularShowsCount = 0
    
    var invokeGetOnTheAirShows = false
    var invokeGetOnTheAirShowsCount = 0
    
    var invokeGetTopRatedShows = false
    var invokeGetTopRatedShowsCount = 0
    
    var invokeGetDetailShow = false
    var invokeGetDetailShowCount = 0
    
    var testRating: Double = 0.0
    
    func getPopularTvShows(pageIndex: Int, completion: @escaping (Result<MovieListChallenge.TvShowResponseModel, Alamofire.AFError>) -> Void) {
        invokeGetPopularShows = true
        invokeGetPopularShowsCount += 1
        completion(.success(dummyList))
    }
    
    func getOnTheAirTvShows(pageIndex: Int, completion: @escaping (Result<MovieListChallenge.TvShowResponseModel, Alamofire.AFError>) -> Void) {
        invokeGetOnTheAirShows = true
        invokeGetOnTheAirShowsCount += 1
        completion(.success(dummyList))
    }
    
    func getTopRatedTvShows(pageIndex: Int, completion: @escaping (Result<MovieListChallenge.TvShowResponseModel, Alamofire.AFError>) -> Void) {
        invokeGetTopRatedShows = true
        invokeGetTopRatedShowsCount += 1
        completion(.success(dummyList))
    }
    
    func getDetailTvShows(showId: Int, completion: @escaping (Result<MovieListChallenge.TvShowDetailResponseModel, Alamofire.AFError>) -> Void) {
        invokeGetDetailShow = true
        invokeGetDetailShowCount += 1
        completion(.success(dummyDetail))
    }
}

// Static Data For Tests.
extension MockNetworkManager {
    private var dummyList: TvShowResponseModel {
        return TvShowResponseModel(page: 1, results: [TvResult(adult: true, backdropPath: "", genreIDS: [0], id: 0, originCountry: ["Türkiye"], overview: "Deneme", popularity: 0.0, posterPath: "", firstAirDate: "", name: "", voteAverage: 0.0, voteCount: 0)], totalPages: 1, totalResults: 1)
    }
    
    private var dummyDetail: TvShowDetailResponseModel {
        return TvShowDetailResponseModel(adult: true, backdropPath: "deneme backdrop", episodeRunTime: [25], firstAirDate: "2023-11-06", homepage: "deneme homepage", id: 0, inProduction: true, languages: [""], lastAirDate: "", name: "deneme name", numberOfEpisodes: 0, numberOfSeasons: 0, originCountry: [""], originalLanguage: "", originalName: "", overview: "deneme overview", popularity: 0.0, posterPath: "deneme poster", status: "", tagline: "", type: "", voteAverage: testRating, voteCount: 0)
    }
}
