//
//  VerticalCellViewModelTest.swift
//  MovieListChallengeTests
//
//  Created by Sezgin Çiftci on 6.11.2023.
//

import XCTest
@testable import MovieListChallenge

final class VerticalCellViewModelTest: XCTestCase {
    
    var sut: VerticalCellViewModel!
    var view: MockVerticalCellView!
    
    override func setUp() {
        super.setUp()
        view = .init()
        sut = .init(view: view, tvShows: [TvResult(adult: true, backdropPath: "", genreIDS: [0], id: 1, originCountry: [], overview: "", popularity: 0.0, posterPath: "", firstAirDate: "", name: "", voteAverage: 0.0, voteCount: 0)], delegate: nil)
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        sut = nil
    }
    
    func test_layoutSubViews() {
        // Because prepare func is in initializer, prepare triggers as soon as initted.
        XCTAssertTrue(view.invokePrepareCollectionView)
        XCTAssertFalse(view.invokeReloadCollectionView)

        sut.layoutSubViews()
        
        XCTAssertEqual(view.invokePrepareCollectionViewCount, 1)
        XCTAssertEqual(view.invokeReloadCollectionViewCount, 1)
    }
}
