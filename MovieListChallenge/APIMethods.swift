//
//  APIMethods.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 3.11.2023.
//

import Foundation
import Alamofire

enum APIMethods: URLRequestConvertible {
  case popular(pageIndex: Int)
  case topRated(pageIndex: Int)
  case onTheAir(pageIndex: Int)
  case detail(movieID: Int)
  
  var path: String {
    switch self {
    case .popular:
      return "popular"
    case .topRated:
      return "top_rated"
    case .onTheAir:
        return "on_the_air"
    case let .detail(detailId):
      return "\(detailId)"
    }
  }
  
  var parameters: Parameters {
    var params: [String: Any] = [ParameterKey.apiKey.rawValue: APIConstants.apiKey,
                                 ParameterKey.language.rawValue: "en-US"]
    
    switch self {
    case .popular(let pageIndex), .topRated(let pageIndex):
      params[ParameterKey.pageIndex.rawValue] = "\(pageIndex)"
      return params
    default:
      return params
    }
  }
  
  var methodType: HTTPMethod {
    switch self {
    case .popular, .topRated, .onTheAir, .detail:
      return .get
    }
  }
  
  var encoding: ParameterEncoding {
    switch self {
    case .popular, .topRated, .onTheAir, .detail:
      return URLEncoding.queryString
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try APIConstants.baseUrl.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = methodType.rawValue
    urlRequest = try encoding.encode(urlRequest, with: parameters)
    return urlRequest
  }
  
  enum ParameterKey: String {
    case language = "language"
    case apiKey = "api_key"
    case pageIndex = "page"
  }
}
