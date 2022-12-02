//
//  HomeViewModel.swift
//  X
//
//  Created by iosDev on 30.11.2022.
//

import Foundation
import Combine

final class HomeViewModel {
    
    // MARK: - Private properties
    private var service: MovieService
    @Published private(set) var state: HomeState = .idle
    
    // MARK: - Init
    init(_ service: MovieService) {
        self.service = service
    }
    
    // MARK: - Public methods
    func start() {
        guard case .idle = state else {
            self.state = .error(.serviceAlreadyStarted)
            return
        }
        do {
            try service.start()
            self.state = convert(service.state)
        } catch {
            self.state = convert(service.state)
        }
    }
    
    func expandedCell(_ id: Int) {
        guard case var .result(movieList) = state else {
            state = .error(.incorrectResult)
            return
        }
        guard let index = movieList.firstIndex(where: { id == $0.movie.id }) else {
            state = .error(.incorrectCellId)
            return
        }
        if movieList[index].isExpanded {
            movieList[index].isExpanded = false
        } else {
            movieList[index].isExpanded = true
        }
        
        state = .result(movieList)
    }
    
    // MARK: - Private methods
    private func convert(_ state: MovieServiceModels.State) -> HomeState {
        switch state {
        case .loaded(let items):
            return .result(items.map({ CellModel($0) }))
        default:
            return .error(.serviceError)
        }
    }
    
}

// MARK: - HomeViewModel state
extension HomeViewModel {
    
    enum HomeState: Equatable {
        
        case idle
        case loading
        case result([CellModel])
        case error(Error)
        
    }
    
    enum Error: Swift.Error {
        
        case serviceAlreadyStarted
        case serviceError
        case incorrectResult
        case incorrectCellId
        
    }
    
}
