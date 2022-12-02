//
//  HomeViewController.swift
//  X
//
//  Created by iosDev on 30.11.2022.
//

import UIKit
import Combine

class HomeViewController: BaseViewController<HomeViewModel> {
    
    // MARK: - IBOutlet's
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loader: LoaderView!
    @IBOutlet private weak var errorLabel: UILabel!
    
    // MARK: - Private properties
    private var subscriptions = Set<AnyCancellable>()
    private var dataSource: UITableViewDiffableDataSource<Section, CellModel>!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDataSource()
        observeViewModelState()
    }
    
    // MARK: - Public methods
    override func observeViewModelState() {
        viewModel.$state.sink { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .idle:
                self.loader.startAnimating()
            case .loading:
                self.hideErrorObjects()
                self.loader.startAnimating()
            case let .result(result):
                self.hideErrorObjects()
                self.loader.stopAnimating()
                self.setData(result)
            case .error:
                self.showError()
                self.loader.stopAnimating()
            }
        }
        .store(in: &subscriptions)
        viewModel.start()
    }
    
    // MARK: - Private methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.registerNib(for: MoviewTableViewCell.self)
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            let cell = tableView.deque(type: MoviewTableViewCell.self,
                                       indexPath: indexPath)
            cell.configure(model)
            cell.onMoreAction = { [unowned self] in
                self.viewModel.expandedCell(model.movie.id)
            }
            cell.onTrailerAction = { [unowned self] in
                self.showTrailer(model.movie.trailerLink)
            }
            return cell
        })
    }
    
    private func setData(_ movieList: [CellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CellModel>()
        snapshot.appendSections([.movies])
        snapshot.appendItems(movieList, toSection: .movies)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func showTrailer(_ url: URL) {
        UIApplication.shared.open(url)
    }
    
    private func showError() {
        tableView.isHidden = true
        errorLabel.isHidden = false
    }
    
    private func hideErrorObjects() {
        tableView.isHidden = false
        errorLabel.isHidden = true
    }
    
}

// MARK: - Section model
extension HomeViewController {
    
    enum Section {
        case movies
    }
    
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
}
