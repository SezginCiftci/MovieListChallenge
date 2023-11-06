//
//  MockVerticalCellView.swift
//  MovieListChallengeTests
//
//  Created by Sezgin Çiftci on 6.11.2023.
//

import Foundation
@testable import MovieListChallenge

final class MockVerticalCellView: VerticalCollectionCellInterface {
    
    var invokePrepareCollectionView = false
    var invokePrepareCollectionViewCount = 0
    
    var invokeReloadCollectionView = false
    var invokeReloadCollectionViewCount = 0
    
    func prepareCollectionView() {
        invokePrepareCollectionView = true
        invokePrepareCollectionViewCount += 1
    }
    
    func reloadCollectionView() {
        invokeReloadCollectionView = true
        invokeReloadCollectionViewCount += 1
    }
}
