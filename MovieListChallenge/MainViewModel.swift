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
    
    weak var view: MainViewInterface?
    
    private var networkManager: NetworkManagerProtocol = NetworkManager()
    private var listInfo: [ListInfo] = []
    
    func viewDidLoad() {
        view?.prepareCollectionView()
        view?.configureNavigationBar(barTitle: "TV Shows",
                                     prefersLargeTitle: true,
                                     barBgColorStr: "navbarBg",
                                     barTitleColorStr: "navbarTitleColor")
        fetchTVShows()
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
    
    let group = DispatchGroup()
    
    private func fetchTVShows(pageIndex: Int = 1) {
        view?.configureLoading(isLoading: true)
        group.enter()
        networkManager.getPopularTvShows(pageIndex: pageIndex,
                                         completion: apiCompletion(listType: .popular))
        group.enter()
        networkManager.getTopRatedTvShows(pageIndex: pageIndex,
                                          completion: apiCompletion(listType: .topRated))
        group.enter()
        networkManager.getOnTheAirTvShows(pageIndex: pageIndex,
                                          completion: apiCompletion(listType: .onTheAir))
        group.notify(queue: DispatchQueue.main) { [weak self] in
            self?.view?.configureLoading(isLoading: false)
            self?.view?.reloadCollectionView()
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
                view?.presentAlert(message: failure.localizedDescription, actions: [])
            }
            group.leave()
        }
    }
}
