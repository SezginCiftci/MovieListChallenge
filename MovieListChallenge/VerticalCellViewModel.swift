//
//  VerticalCellViewModel.swift
//  MovieListChallenge
//
//  Created by Sezgin Çiftci on 4.11.2023.
//

import Foundation

protocol VerticalCellViewModelInterface {
    var view: VerticalCollectionCellInterface? { get set }
    
    func layoutSubViews()
    func cellForRow(at index: IndexPath) -> TvResult?
    func numberOfRow(in section: Int) -> Int
    func didSelectItem(at index: IndexPath)
}

protocol VerticalCollectionCellDelegate {
    func didSelectShow(showId: Int)
}

final class VerticalCellViewModel: VerticalCellViewModelInterface {
    
    var view: VerticalCollectionCellInterface?
    var delegate: VerticalCollectionCellDelegate
    var tvShows: [TvResult]
    
    init(view: VerticalCollectionCellInterface? = nil,
         tvShows: [TvResult],
         delegate: VerticalCollectionCellDelegate) {
        self.view = view
        self.tvShows = tvShows
        self.delegate = delegate
        layoutSubViews()
        !tvShows.isEmpty ? view?.reloadCollectionView() : nil
    }
    
    func layoutSubViews() {
        view?.prepareCollectionView()
    }
    
    func cellForRow(at index: IndexPath) -> TvResult? {
        return tvShows[index.row]
    }
    
    func numberOfRow(in section: Int) -> Int {
        return tvShows.count
    }
    
    func didSelectItem(at index: IndexPath) {
        if let showId = tvShows[index.row].id {
            delegate.didSelectShow(showId: showId)
        }
    }
}
