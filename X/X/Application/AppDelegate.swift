//
//  AppDelegate.swift
//  X
//
//  Created by iosDev on 30.11.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Private properties
    private lazy var containter = AppDIContainer.shared
    
    // MARK: - Public properties
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewModel = HomeViewModel(containter.parseService)
        let rootViewController = HomeViewController(viewModel: viewModel)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
}

