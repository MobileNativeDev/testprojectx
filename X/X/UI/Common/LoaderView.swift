//
//  LoaderView.swift
//  X
//
//  Created by iosDev on 30.11.2022.
//

import UIKit

class LoaderView: UIView {
    
    // MARK: - Private properties
    private var color: UIColor
    private var scaleFactor: CGFloat
    private let activityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - Public properties
    var hideWhenStopped: Bool = true {
        didSet {
            activityIndicatorView.hidesWhenStopped = hideWhenStopped
        }
    }
    
    // MARK: - Fires activity indicator animation
    var loading: Bool = true {
        didSet {
            if loading {
                startAnimating()
            } else {
                stopAnimating()
            }
        }
    }
    
    var style: UIActivityIndicatorView.Style = .large {
        didSet {
            activityIndicatorView.style = style
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.color = .black
        scaleFactor = 1.0
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        self.color = .black
        scaleFactor = 1.0
        super.init(coder: coder)
        self.setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        activityIndicatorView.style = style
        activityIndicatorView.hidesWhenStopped = hideWhenStopped
        activityIndicatorView.color = color
        activityIndicatorView.transform = .init(scaleX: scaleFactor, y: scaleFactor)
        startAnimating()
        self.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // MARK: - Public methods
    func startAnimating() {
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }
    
}
