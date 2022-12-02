//
//  BaseViewController.swift
//  X
//
//  Created by iosDev on 30.11.2022.
//

import UIKit
import Combine

class BaseViewController<ViewModel>: UIViewController {
    
    // MARK: - Public properties
    var viewModel: ViewModel
    
    // MARK: - Init
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Public methods
    func observeViewModelState() {}
    
}
