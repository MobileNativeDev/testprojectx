//
//  MovieListService.swift
//  X
//
//  Created by iosDev on 01.12.2022.
//

import Foundation

protocol MovieService: AnyObject {
    
    var state: MovieServiceModels.State { get }
    func start() throws
    
}

final class MovieListService: MovieService {
    
    // MARK: - Private properties
    private(set) var state: MovieServiceModels.State
    private let fileName: String
    private let decoder: JSONDecoder
    
    // MARK: Init
    init(fileName: String) {
        self.fileName = fileName
        self.decoder = JSONDecoder()
        state = .idle
    }
    
    // MARK: - Public methods
    func start() throws {
        guard case .idle = state else {
            throw MovieServiceModels.Error.serviceAlreadyStarted
        }
        switch Bundle.main.url(forResource: fileName, withExtension: "json") {
        case .some(let url):
            switch try? Data(contentsOf: url) {
            case .some(let data) where data.count > 1:
                switch try? decoder.decode(MovieList.self, from: data) {
                case .some(let list):
                    self.state = .loaded(list.movieList)
                default:
                    self.state = .failure(.decodingError)
                }
            default:
                self.state = .failure(.brokenData)
            }
        case .none:
            self.state = .failure(.invalidURL)
        }
    }
}

// MARK: - MovieServiceModels state
enum MovieServiceModels {
    
    enum State: Equatable {
        
        case idle
        case loaded([Movie])
        case failure(MovieServiceModels.Error)
        
    }
    
    enum Error: Swift.Error {
        
        case invalidURL
        case brokenData
        case decodingError
        case serviceAlreadyStarted
        
    }
    
}
