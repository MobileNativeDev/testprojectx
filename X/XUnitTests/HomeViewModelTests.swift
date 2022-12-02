//
//  HomeViewModelTests.swift
//  XUnitTests
//
//  Created by iosDev on 01.12.2022.
//

import XCTest
@testable import X

class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        let service = MovieListService(fileName: "X")
        sut = HomeViewModel(service)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInitialStateIsIdle() {
        XCTAssertTrue(sut.state == .idle)
    }
    
    func testMoviesLoadSuccess() {
        let moviesList = Constants.successResult
        sut.start()
        XCTAssertEqual(sut.state, .result(moviesList))
    }
    
    func testMoviesLoadFailed() {
        let service = MovieListService(fileName: "XX")
        sut = HomeViewModel(service)
        sut.start()
        XCTAssertTrue(sut.state == .error(.serviceError))
    }
    
    func testAlreadyStarted() {
        sut.start()
        sut.start()
        XCTAssertTrue(sut.state == .error(.serviceAlreadyStarted))
    }
    
    func testIncorrectCellId() throws {
        sut.start()
        sut.expandedCell(100)
        XCTAssertTrue(sut.state == .error(.incorrectCellId))
    }
    
    func testChangeExpandedValue() {
        let expandedMoviesList = Constants.expandedResult
        let defaultMovieList = Constants.successResult
        sut.start()
        sut.expandedCell(1)
        XCTAssertEqual(sut.state, .result(expandedMoviesList))
        sut.expandedCell(1)
        XCTAssertEqual(sut.state, .result(defaultMovieList))
    }
    
}

extension HomeViewModelTests {
    
    enum Constants {
        
        static let successResult: [CellModel] = [
            CellModel(
                .init(
                    id: 1,
                    title: "Tenet",
                    description: "Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time",
                    rating: 7.8,
                    duration: "2h 30 min",
                    genre: "Action, Sci-Fi",
                    releasedDate: "3 September 2020",
                    trailerLink: URL(string: "https://www.youtube.com/watch?v=LdOM0x0XDMo")!
                ),
                false
            ),
            CellModel(
                .init(
                    id: 2,
                    title: "Spider-Man: Into the Spider-Verse",
                    description: "Teen Miles Morales becomes the Spider-Man of his universe, and must join with five spider-powered individuals from other dimensions to stop a threat for all realities.",
                    rating: 8.4,
                    duration: "1h 57min",
                    genre: "Action, Animation, Adventure",
                    releasedDate: "14 December 2018",
                    trailerLink: URL(string: "https://www.youtube.com/watch?v=tg52up16eq0")!
                ),
                false
            ),
            CellModel(
                .init(
                    id: 3,
                    title: "Knives Out",
                    description: "A detective investigates the death of a patriarch of an eccentric, combative family.",
                    rating: 7.9,
                    duration: "2h 10min",
                    genre: "Comedy, Crime, Drama",
                    releasedDate: "27 November 2019",
                    trailerLink: URL(string: "https://www.youtube.com/watch?v=qGqiHJTsRkQ")!
                ),
                false
            ),
            CellModel(
                .init(
                    id: 4,
                    title: "Guardians of the Galaxy",
                    description: "A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe.",
                    rating: 8.0,
                    duration: "2h 1min",
                    genre: "Action, Adventure, Comedy",
                    releasedDate: "1 August 2014",
                    trailerLink: URL(string: "https://www.youtube.com/watch?v=d96cjJhvlMA")!
                ),
                false
            ),
            CellModel(
                .init(
                    id: 5,
                    title: "Avengers: Age of Ultron",
                    description: "When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan.",
                    rating: 7.3,
                    duration: "2h 21min",
                    genre: "Action, Adventure, Sci-Fi",
                    releasedDate: "1 May 2015",
                    trailerLink: URL(string: "https://www.youtube.com/watch?v=tmeOjFno6Do")!
                ),
                false
            )
        ]
        
        static let expandedResult: [CellModel] = [
            CellModel(
                .init(
                    id: 1,
                    title: "Tenet",
                    description: "Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time",
                    rating: 7.8,
                    duration: "2h 30 min",
                    genre: "Action, Sci-Fi",
                    releasedDate: "3 September 2020",
                    trailerLink: URL(string: "https://www.youtube.com/watch?v=LdOM0x0XDMo")!
                ),
                true
            ),
            CellModel(
                .init(
                    id: 2,
                    title: "Spider-Man: Into the Spider-Verse",
                    description: "Teen Miles Morales becomes the Spider-Man of his universe, and must join with five spider-powered individuals from other dimensions to stop a threat for all realities.",
                    rating: 8.4,
                    duration: "1h 57min",
                    genre: "Action, Animation, Adventure",
                    releasedDate: "14 December 2018",
                    trailerLink: URL(string: "https://www.youtube.com/watch?v=tg52up16eq0")!
                ),
                false
            ),
            CellModel(
                .init(
                    id: 3,
                    title: "Knives Out",
                    description: "A detective investigates the death of a patriarch of an eccentric, combative family.",
                    rating: 7.9,
                    duration: "2h 10min",
                    genre: "Comedy, Crime, Drama",
                    releasedDate: "27 November 2019",
                    trailerLink: URL(string: "https://www.youtube.com/watch?v=qGqiHJTsRkQ")!
                ),
                false
            ),
            CellModel(
                .init(
                    id: 4,
                    title: "Guardians of the Galaxy",
                    description: "A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe.",
                    rating: 8.0,
                    duration: "2h 1min",
                    genre: "Action, Adventure, Comedy",
                    releasedDate: "1 August 2014",
                    trailerLink: URL(string: "https://www.youtube.com/watch?v=d96cjJhvlMA")!
                ),
                false
            ),
            CellModel(
                .init(
                    id: 5,
                    title: "Avengers: Age of Ultron",
                    description: "When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan.",
                    rating: 7.3,
                    duration: "2h 21min",
                    genre: "Action, Adventure, Sci-Fi",
                    releasedDate: "1 May 2015",
                    trailerLink: URL(string: "https://www.youtube.com/watch?v=tmeOjFno6Do")!
                ),
                false
            )
        ]
        
    }
    
}
