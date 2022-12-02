//
//  MovieList.swift
//  X
//
//  Created by iosDev on 30.11.2022.
//

import Foundation

// MARK: - MovieList
struct MovieList: Codable {
    
    let movieList: [Movie]
    
}

// MARK: - Movie
struct Movie: Codable, Equatable, Hashable {
    
    let id: Int
    let title: String
    let description: String
    let rating: Double
    let duration: String
    let genre: String
    let releasedDate: String
    let trailerLink: URL
    
}

// MARK: CellModel
struct CellModel: Equatable, Hashable {
    
    let movie: Movie
    var isExpanded = false
    
    init(_ movie: Movie, _ isExpanded: Bool = false) {
        self.movie = movie
        self.isExpanded = isExpanded
    }
    
}
