//
//  RocketsListView.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 24.01.2021.
//

import Combine
import UIKit

final class RocketsListView: UIViewController {
    weak var coordinatorDelegate: RocketsListViewCoordinatorDelegate?
    
    private var collectionViewLayout: UICollectionViewLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.5))
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        RocketsListItemView.registerNib(for: collectionView)
        return collectionView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private var cancellable = Set<AnyCancellable>()
    private let viewModel: RocketsListViewModel
    
    // MARK: - Initialization
    
    init(viewModel: RocketsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MAKR: - Viwe Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rockets 🚀"
        view.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        configureHierarchy()
        setupLayoutConstraints()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchRockets()
    }
    
    // MARK: - Layout
    
    private func configureHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Data Binding
    
    private func setupBindings() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellable)
        
        viewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellable)
    }
}

extension RocketsListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RocketsListItemView = .dequeue(from: collectionView, for: indexPath)
        cell.setup(with: viewModel.items[indexPath.row])
        return cell
    }
}

extension RocketsListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.items[indexPath.row]
        coordinatorDelegate?.openRocketDetailPage(rocketId: model.rocketId, rocketName: model.name)
    }
}
