//
//  DetailViewModel.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 3.11.2023.
//

import Foundation

protocol DetailViewModelInterface {
    var view: DetailViewInterface? { get set }
    var homepage: URL? { get }
    var showTitle: String { get }
    var overview: String { get }
    var runTime: String { get }
    var firstAir: String { get }
    var topImageURL: String { get }
    var posterImageURL: String { get }
    var getStarImageNames: [String] { get }
    
    func viewDidLoad()
}

final class DetailViewModel: DetailViewModelInterface {
    
    weak var view: DetailViewInterface?
    var networkManager: NetworkManagerProtocol = NetworkManager()
    var responseDetail: TvShowDetailResponseModel?
    var showId: Int
    
    init(showId: Int) {
        self.showId = showId
    }
    
    func viewDidLoad() {
        view?.configureNavigationBar(barTitle: "TV Shows",
                                     prefersLargeTitle: true,
                                     barBgColorStr: "navbarBg",
                                     barTitleColorStr: "navbarTitleColor")
        fetchDetail()
    }
    
    var homepage: URL? {
        return responseDetail?.homepageURL
    }
    
    var showTitle: String {
        return responseDetail?.name ?? ""
    }
    
    var overview: String {
        return responseDetail?.overview ?? ""
    }
    
    var runTime: String {
        return String(responseDetail?.episodeRunTime?.first ?? 0) + "min."
    }
    
    var firstAir: String {
        return responseDetail?.firstAirDate.configureDate() ?? ""
    }
    
    var topImageURL: String {
        return responseDetail?.backdropURL ?? ""
    }
    
    var posterImageURL: String {
        return responseDetail?.posterURL ?? ""
    }
    
    var getStarImageNames: [String] {
        return configureStars().count == 5 ? configureStars() : []
    }
    
    private func configureStars() -> [String] {
        let voteRate: Double = responseDetail?.voteAverage ?? 0.0
        let scaleToFive = voteRate/2
        var starArray = [String]()
        let remainder: Double = scaleToFive - Double(Int(scaleToFive))
        for _ in 0..<Int(scaleToFive) {
            starArray.append("star.fill")
        }
        if remainder != 0, remainder >= 0.5 {
            starArray.append("star.leadinghalf.filled")
        }
        if starArray.count < 5 {
            for _ in 0..<(5-Int(scaleToFive.rounded())) {
                starArray.append("star")
            }
        }
        return starArray
    }
    
    private func fetchDetail() {
        networkManager.getDetailTvShows(showId: showId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.responseDetail = success
                self.view?.updateUI()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
