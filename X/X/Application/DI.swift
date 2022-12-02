//
//  DI.swift
//  X
//
//  Created by X on 01.12.2022.
//

import Foundation

final class AppDIContainer {
    
    static let shared = AppDIContainer.init()
    
    lazy var parseService = MovieListService(fileName: "X")
    
    // MARK: - init
    private init() {}
 
}
