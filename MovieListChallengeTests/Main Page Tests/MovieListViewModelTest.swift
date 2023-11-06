//
//  MovieListViewModelTest.swift
//  MovieListChallengeTests
//
//  Created by Sezgin Çiftci on 6.11.2023.
//

import XCTest
@testable import MovieListChallenge

final class MovieListViewModelTest: XCTestCase {
    
    private var sut: MainViewModel!
    private var view: MockMainViewController!
    private var networkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        view = .init()
        networkManager = .init()
        sut = .init(view: view, networkManager: networkManager)
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        networkManager = nil
        sut = nil
    }
    
    func test_viewDidLoad() {
        XCTAssertFalse(view.invokePrepareCollectionView)
        XCTAssertFalse(view.invokeLoadingStarted)
        XCTAssertFalse(view.invokeReloadCollectionView)
        XCTAssertFalse(view.invokeLoadingEnded)
        XCTAssertFalse(networkManager.invokeGetPopularShows)
        XCTAssertFalse(networkManager.invokeGetTopRatedShows)
        XCTAssertFalse(networkManager.invokeGetOnTheAirShows)

        sut.viewDidLoad()
        
        XCTAssertEqual(view.invokePrepareCollectionViewCount, 1)
        XCTAssertEqual(view.invokeLoadingStartedCount, 1)
        XCTAssertEqual(networkManager.invokeGetPopularShowsCount, 1)
        XCTAssertEqual(networkManager.invokeGetTopRatedShowsCount, 1)
        XCTAssertEqual(networkManager.invokeGetOnTheAirShowsCount, 1)
        let expectation = XCTestExpectation(description: "receivedValue")
        DispatchQueue.main.async {
            XCTAssertEqual(self.view.invokeReloadCollectionViewCount, 1)
            XCTAssertEqual(self.view.invokeLoadingEndedCount, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func test_cellForRowAt() {
        sut.viewDidLoad()
        let expectation = XCTestExpectation(description: "receivedValue")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        
        let tvResult = sut.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertFalse(tvResult.isEmpty)
        XCTAssertEqual(tvResult[0].overview, "Deneme")
        XCTAssertEqual(tvResult[0].originCountry?.first, "Türkiye")
    }
    
    func test_numberOfSections() {
        sut.viewDidLoad()
        let expectation = XCTestExpectation(description: "receivedValue")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        
        let tvResult = sut.numberOfSections()
        XCTAssertTrue(tvResult > 0)
    }
}
