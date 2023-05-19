//
//  MAMovieDetailView.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 19/05/23.
//

import Foundation

import UIKit

/// VIew for single movie info
final class MAMovieDetailView: UIView {
    
    public var collectionView: UICollectionView?
    
    private let viewModel: MAMovieDetailViewViewModel
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Init
    
    init(frame: CGRect, viewModel: MAMovieDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        self.collectionView?.alpha = 0
        addSubviews(collectionView, spinner)
        addConstraints()
        
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchMovieDetail()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        guard let collectionView = collectionView else {
            return
        }
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MAMoviePhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: MAMoviePhotoCollectionViewCell.cellIdentifer)
        collectionView.register(MAMovieInfoCollectionViewCell.self,
                                forCellWithReuseIdentifier: MAMovieInfoCollectionViewCell.cellIdentifer)
        collectionView.register(MAMoviePlotCollectionViewCell.self,
                                forCellWithReuseIdentifier: MAMoviePlotCollectionViewCell.cellIdentifer)
        collectionView.register(MAMovieFullCastCollectionViewCell.self,
                                forCellWithReuseIdentifier: MAMovieFullCastCollectionViewCell.cellIdentifer)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections
        switch sectionTypes[sectionIndex]  {
            case .photo:
                return viewModel.createPhotoSectionLayout()
            case .information:
                return viewModel.createInfoSectionLayout()
            case .plot:
                return viewModel.createPlotSectionLayout()
            case .fullCast:
                return viewModel.createCastSectionLayout()
        }
    }
}

extension MAMovieDetailView: MAMovieDetailViewViewModelDelegate {
    func didLoadMovieDetails() {
        spinner.stopAnimating()
        
        self.collectionView?.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView?.alpha = 1
            
        }
    }
    
    
}
