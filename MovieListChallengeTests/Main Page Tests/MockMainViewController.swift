//
//  MockMainViewController.swift
//  MovieListChallengeTests
//
//  Created by Sezgin Çiftci on 6.11.2023.
//

import UIKit
@testable import MovieListChallenge

final class MockMainViewController: UIViewController, MainViewInterface {
    
    var invokePrepareCollectionView = false
    var invokePrepareCollectionViewCount = 0

    var invokeReloadCollectionView = false
    var invokeReloadCollectionViewCount = 0
    
    var invokeLoadingStarted = false
    var invokeLoadingStartedCount = 0
    
    var invokeLoadingEnded = false
    var invokeLoadingEndedCount = 0
    
    func prepareCollectionView() {
        invokePrepareCollectionView = true
        invokePrepareCollectionViewCount += 1
    }
    
    func reloadCollectionView() {
        invokeReloadCollectionView = true
        invokeReloadCollectionViewCount += 1
    }
    
    func configureLoading(isLoading: Bool) {
        switch isLoading {
        case true:
            invokeLoadingStarted = true
            invokeLoadingStartedCount += 1
        case false:
            invokeLoadingEnded = true
            invokeLoadingEndedCount += 1
        }
    }
}
