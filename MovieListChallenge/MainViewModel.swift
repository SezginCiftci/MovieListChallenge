//
//  MainViewModel.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 3.11.2023.
//

import Foundation
import Alamofire

protocol MainViewModelInterface {
    func viewDidLoad()
    func viewWillAppear()
    func cellForRow(at index: IndexPath) -> [TvResult]
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func titleForHeader(at index: IndexPath) -> String
}

final class MainViewModel: MainViewModelInterface {
    
    private weak var view: MainViewInterface?
    private var networkManager: NetworkManagerProtocol
    
    private var listInfo: [ListArguments] = []
    private let group = DispatchGroup()
    
    init(view: MainViewInterface? = nil,
         networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.view = view
        self.networkManager = networkManager
    }
    
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
                self.listInfo.append(ListArguments(listType: listType, tvShowResponse: success))
            case .failure(let failure):
                view?.presentAlert(message: failure.localizedDescription, actions: [])
            }
            group.leave()
        }
    }
}
