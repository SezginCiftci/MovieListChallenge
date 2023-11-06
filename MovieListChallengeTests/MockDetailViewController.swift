//
//  MockDetailViewController.swift
//  MovieListChallengeTests
//
//  Created by Sezgin Çiftci on 6.11.2023.
//

import UIKit
@testable import MovieListChallenge


final class MockDetailViewController: UIViewController, DetailViewInterface {
    
    var invokeUpdateUI = false
    var invokeUpdateUICount = 0
    
    var invokeLoadingStarted = false
    var invokeLoadingStartedCount = 0
    
    var invokeLoadingEnded = false
    var invokeLoadingEndedCount = 0
    
    func updateUI() {
        invokeUpdateUI = true
        invokeUpdateUICount += 1
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
