//
//  NetworkManager.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 3.11.2023.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func getPopularTvShows(pageIndex: Int, completion: @escaping (Result<TvShowResponseModel, AFError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    func getPopularTvShows(pageIndex: Int, completion: @escaping (Result<TvShowResponseModel, AFError>) -> Void) {
        request(method: .popular(pageIndex: pageIndex), completion: completion)
    }
    
    func getOnTheAirTvShows(pageIndex: Int, completion: @escaping (Result<TvShowResponseModel, AFError>) -> Void) {
        request(method: .onTheAir(pageIndex: pageIndex), completion: completion)
    }
    
    func getTopRatedTvShows(pageIndex: Int, completion: @escaping (Result<TvShowResponseModel, AFError>) -> Void) {
        request(method: .topRated(pageIndex: pageIndex), completion: completion)
    }
    
    func getDetailTvShows(showId: Int, completion: @escaping (Result<TvShowResponseModel, AFError>) -> Void) {
        request(method: .detail(showId: showId), completion: completion)
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
