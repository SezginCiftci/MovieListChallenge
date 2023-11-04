//
//  ListInfo.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 4.11.2023.
//

import Foundation

struct ListInfo {
    var listType: ListType
    var tvShowResponse: TvShowResponseModel
//    var currentPage: Int
//    var totalPages: Int
    
    init(listType: ListType, tvShowResponse: TvShowResponseModel) {
        self.listType = listType
        self.tvShowResponse = tvShowResponse
//        self.currentPage = currentPage
//        self.totalPages = totalPages
    }
}

enum ListType: Int, CaseIterable {
    case popular = 0
    case topRated
    case onTheAir
    
    var listHeaders: String {
        switch self {
        case .popular:
            return "Popular Shows"
        case .topRated:
            return "Top Rated Shows"
        case .onTheAir:
            return "Shows On The Air Now"
        }
    }
}

