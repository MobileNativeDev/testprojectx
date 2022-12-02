//
//  MovieListServiceTests.swift
//  XUnitTests
//
//  Created by iosDev on 01.12.2022.
//

import XCTest
@testable import X

class MovieListServiceTests: XCTestCase {
    
    func testInvalidPath() throws {
        let service = MovieListService(fileName: "Some")
        try service.start()
        XCTAssert(service.state == .failure(.invalidURL))
    }
    
    func testInvalidJSON() throws {
        let service = MovieListService(fileName: "InvalidJSON")
        try service.start()
        XCTAssert(service.state == .failure(.decodingError))
    }
    
    func testSuccessParse() throws {
        let service = MovieListService(fileName: "X")
        try service.start()
        switch service.state {
        case .loaded:
            XCTAssert(true)
        default:
            XCTAssert(false)
        }
    }
    
    func testBrokenData() throws {
        let service = MovieListService(fileName: "EmptyFile")
        try service.start()
        XCTAssert(service.state == .failure(.brokenData))
    }
    
    func testAlreadyStarted() {
        let service = MovieListService(fileName: "X")
        do {
            try service.start()
            try service.start()
        } catch let error {
            XCTAssert(error as! MovieServiceModels.Error == MovieServiceModels.Error.serviceAlreadyStarted)
        }
    }
    
}
