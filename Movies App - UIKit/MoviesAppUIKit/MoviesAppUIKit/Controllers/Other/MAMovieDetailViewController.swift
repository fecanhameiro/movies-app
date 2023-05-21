//
//  MAMovieDetailViewController.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import UIKit

/// CA UIViewController subclass managing the interactions and data of the movie detail view.
final class MAMovieDetailViewController: UIViewController {
    private let viewModel: MAMovieDetailViewViewModel
    
    private let detailView: MAMovieDetailView
    
    // MARK: - Init
    
    init(viewModel: MAMovieDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = MAMovieDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailView)
        addConstraints()
        
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
        
        
    }
    
    @objc
    private func didTapShare() {
        // Share character info
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - CollectionView

extension MAMovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
            case .photo:
                return 1
            case .information(let viewModels):
                return viewModels.count
            case .plot:
                return 1
            case .fullCast(let viewModels):
                return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
            case .photo(let viewModel):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MAMoviePhotoCollectionViewCell.cellIdentifer,
                    for: indexPath
                ) as? MAMoviePhotoCollectionViewCell else {
                    fatalError()
                }
                cell.configure(with: viewModel)
                return cell
            case .information(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MAMovieInfoCollectionViewCell.cellIdentifer,
                    for: indexPath
                ) as? MAMovieInfoCollectionViewCell else {
                    fatalError()
                }
                cell.configure(with: viewModels[indexPath.row])
                return cell
            case .plot(let viewModel):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MAMoviePlotCollectionViewCell.cellIdentifer,
                    for: indexPath
                ) as? MAMoviePlotCollectionViewCell else {
                    fatalError()
                }
                cell.configure(with: viewModel)
                return cell
            case .fullCast(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MAMovieFullCastCollectionViewCell.cellIdentifer,
                    for: indexPath
                ) as? MAMovieFullCastCollectionViewCell else {
                    fatalError()
                }
                let viewModel = viewModels[indexPath.row]
                cell.configure(with: viewModel)
                return cell
        }
    }

}

