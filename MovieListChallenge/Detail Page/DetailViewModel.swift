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
    
    private func calculateStars() -> [String] {
        let voteRate: Double = responseDetail?.voteAverage ?? 0.0
        let scaleToFive = min(voteRate / 2, 5.0)
        var starArray = [String]()
        for _ in 0..<Int(scaleToFive) {
            starArray.append("star.fill")
        }
        if scaleToFive.truncatingRemainder(dividingBy: 1.0) >= 0.5 {
            starArray.append("star.leadinghalf.filled")
        }
        while starArray.count < 5 {
            starArray.append("star")
        }
        return starArray.count == 5 ? starArray : []
    }
    
    private func fetchDetail() {
        view?.configureLoading(isLoading: true)
        networkManager.getDetailTvShows(showId: showId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.responseDetail = success
                self.view?.updateUI()
            case .failure(let failure):
                view?.presentAlert(message: failure.localizedDescription, actions: [])
            }
            self.view?.configureLoading(isLoading: false)
        }
    }
}

//MARK: Detail View Datas
extension DetailViewModel {
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
        return calculateStars()
    }
}
