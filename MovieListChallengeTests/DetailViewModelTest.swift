//
//  DetailViewModelTest.swift
//  MovieListChallengeTests
//
//  Created by Sezgin Çiftci on 6.11.2023.
//

import XCTest
@testable import MovieListChallenge

final class DetailViewModelTest: XCTestCase {
    
    private var sut: DetailViewModel!
    private var view: MockDetailViewController!
    private var networkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        view = .init()
        networkManager = .init()
        sut = .init(view: view, networkManager: networkManager, showId: 94722)
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        networkManager = nil
        sut = nil
    }
    
    func test_viewDidLoad() {
        XCTAssertFalse(view.invokeLoadingStarted)
        XCTAssertFalse(view.invokeLoadingEnded)
        XCTAssertFalse(view.invokeUpdateUI)
        XCTAssertFalse(networkManager.invokeGetDetailShow)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(view.invokeLoadingStartedCount, 1)
        let expectation = XCTestExpectation(description: "receivedValue")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.view.invokeLoadingEndedCount, 1)
            XCTAssertEqual(self.view.invokeUpdateUICount, 1)
            XCTAssertEqual(self.networkManager.invokeGetDetailShowCount, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    // Detail ViewModel UI Elements That Returns To View.
    func test_viewModelPresentDatas() {
        XCTAssertNil(sut.homepage)
        XCTAssertEqual(sut.showTitle, "")
        XCTAssertEqual(sut.overview, "")
        XCTAssertEqual(sut.runTime, "0 min.")
        XCTAssertEqual(sut.firstAir, "")
        XCTAssertEqual(sut.topImageURL, "")
        XCTAssertEqual(sut.posterImageURL, "")
        
        sut.viewDidLoad()
        
        let expectation = XCTestExpectation(description: "receivedValue")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.sut.homepage, URL(string: "deneme homepage"))
            XCTAssertEqual(self.sut.showTitle, "deneme name")
            XCTAssertEqual(self.sut.overview, "deneme overview")
            XCTAssertEqual(self.sut.runTime, "25 min.")
            XCTAssertEqual(self.sut.firstAir, "11/06/2023")
            XCTAssertEqual(self.sut.topImageURL, "https://image.tmdb.org/t/p/w500" + "deneme backdrop")
            XCTAssertEqual(self.sut.posterImageURL, "https://image.tmdb.org/t/p/w500" + "deneme poster")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    // Star Calculation Test For General Usage.
    func starExpectations(rating: Double, stars: [StarType]) {
        XCTAssertEqual(sut.getStarImageNames.count, 5)
        var starArray: [StarType] = [.star, .star, .star, .star, .star]
        XCTAssertEqual(sut.getStarImageNames, starArray)
        
        networkManager.testRating = rating
        sut.viewDidLoad()
        
        let expectation = XCTestExpectation(description: "receivedValue")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            starArray = stars
            XCTAssertEqual(self.sut.getStarImageNames, starArray)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    // Star Calculation Test For Possible Cases.
    func test_calculateFiveStars() {
        starExpectations(rating: 10.0,
                         stars: [.starFilled, .starFilled, .starFilled, .starFilled, .starFilled])
    }
        
    func test_calculateFourAndHalfStars() {
        starExpectations(rating: 9.2,
                         stars: [.starFilled, .starFilled, .starFilled, .starFilled, .starHalfFilled])
    }

    func test_calculateFourStars() {
        starExpectations(rating: 8.2,
                         stars: [.starFilled, .starFilled, .starFilled, .starFilled, .star])
    }

    func test_calculateThreeAndHalfStars() {
        starExpectations(rating: 7.9,
                         stars: [.starFilled, .starFilled, .starFilled, .starHalfFilled, .star])
    }

    func test_calculateThreeStars() {
        starExpectations(rating: 6.3,
                         stars: [.starFilled, .starFilled, .starFilled, .star, .star])
    }

    func test_calculateTwoAndHalfStars() {
        starExpectations(rating: 5.2,
                         stars: [.starFilled, .starFilled, .starHalfFilled, .star, .star])
    }

    func test_calculateTwoStars() {
        starExpectations(rating: 4.6,
                         stars: [.starFilled, .starFilled, .star, .star, .star])
    }

    func test_calculateOneAndHalfStars() {
        starExpectations(rating: 3.5,
                         stars: [.starFilled, .starHalfFilled, .star, .star, .star])
    }

    func test_calculateOneStars() {
        starExpectations(rating: 2.1,
                         stars: [.starFilled, .star, .star, .star, .star])
    }

    func test_calculateHalfStars() {
        starExpectations(rating: 1.3,
                         stars: [.starHalfFilled, .star, .star, .star, .star])
    }

    func test_calculateZeroStars() {
        starExpectations(rating: 0.2,
                         stars: [.star, .star, .star, .star, .star])
    }
}
