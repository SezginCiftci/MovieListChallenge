//
//  MainViewModel.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 3.11.2023.
//

import Foundation
import Alamofire

protocol MainViewModelInterface {
    var view: MainViewInterface? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func cellForRow(at index: IndexPath) -> [TvResult]
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func titleForHeader(at index: IndexPath) -> String
}

final class MainViewModel: MainViewModelInterface {
    
    var view: MainViewInterface?
    
    private var networkManager: NetworkManagerProtocol = NetworkManager()
    private var listInfo: [ListInfo] = []
    
    func viewDidLoad() {
        view?.prepareCollectionView()
        view?.prepareNavigationBar(navbarTitle: "TV Shows",
                                   bgColor: "navbarBg",
                                   textColor: "navbarTitleColor")
        fetchTvShows(listType: .popular)
        fetchTvShows(listType: .topRated)
        fetchTvShows(listType: .onTheAir)
    }
    
    func viewWillAppear() {
    }
    
    func cellForRow(at index: IndexPath) -> [TvResult] {
        return listInfo[index.section].tvShowResponse.results ?? []
    }
    
    func numberOfSections() -> Int {
        return listInfo.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return 1
    }
    
    func titleForHeader(at index: IndexPath) -> String {
        return listInfo[index.section].listType.listHeaders
    }
    
    func fetchTvShows(listType: ListType, pageIndex: Int = 1) {
        switch listType {
        case .popular:
            networkManager.getPopularTvShows(pageIndex: pageIndex, completion: apiCompletion(listType: listType))
        case .topRated:
            networkManager.getTopRatedTvShows(pageIndex: pageIndex, completion: apiCompletion(listType: listType))
        case .onTheAir:
            networkManager.getOnTheAirTvShows(pageIndex: pageIndex, completion: apiCompletion(listType: listType))
        }
    }
    
    private func apiCompletion(listType: ListType) -> ((Result<TvShowResponseModel, AFError>) -> Void)  {
        return { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.listInfo.append(ListInfo(listType: listType, tvShowResponse: success))
                self.view?.reloadCollectionView()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
