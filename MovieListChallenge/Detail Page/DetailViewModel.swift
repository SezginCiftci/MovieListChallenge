//
//  DetailViewModel.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 3.11.2023.
//

import Foundation

protocol DetailViewModelInterface {
    var view: DetailViewInterface? { get set }
    
    func viewDidLoad()
}

final class DetailViewModel: DetailViewModelInterface {
    
    weak var view: DetailViewInterface?
    var networkManager: NetworkManagerProtocol = NetworkManager()
    var responseDetail: TvShowDetailResponseModel?
    var showId: Int
    
    var homepage: URL? {
        return responseDetail?.homepageURL
    }
    
    init(showId: Int) {
        self.showId = showId
    }
    
    func viewDidLoad() {
        view?.prepareNavigationBar()
        fetchDetail()
    }
    
    func updateUI() {
        view?.updateUI(showTitle: responseDetail?.name ?? "",
                       description: responseDetail?.overview ?? "",
                       runTime: String(responseDetail?.episodeRunTime?.first ?? 0),
                       firstAir: responseDetail?.firstAirDate ?? "",
                       starArray: configureStars(),
                       topImageURL: responseDetail?.backdropURL ?? "",
                       posterImageURL: responseDetail?.posterURL ?? "")
    }
    
    private func configureStars() -> [String] {
        var starArray: [StarTypes] = []
        let fiveScaleRate = (responseDetail?.voteAverage ?? 0.0)/2
        for _ in 0...Int(fiveScaleRate.rounded()) {
            starArray.append(.starFilled)
        }
        starArray.count < 5 ? starArray.append(.starHalf) : nil
        if starArray.count < 5 {
            for _ in 0...(5-starArray.count) {
                starArray.append(.star)
            }
        }
        return starArray.map { $0.starImageName }
    }
    
    //TODO: Burayı doğrudan raw ile alıp işlemi buranın içine taşımayı dene.
    private func fetchDetail() {
        networkManager.getDetailTvShows(showId: showId) { result in
            switch result {
            case .success(let success):
                self.responseDetail = success
                self.updateUI()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private enum StarTypes {
        case starFilled
        case star
        case starHalf
        
        var starImageName: String {
            switch self {
            case .starFilled:
                return "star.fill"
            case .star:
                return "star"
            case .starHalf:
                return "star.leadinghalf.filled"
            }
        }
    }
}
