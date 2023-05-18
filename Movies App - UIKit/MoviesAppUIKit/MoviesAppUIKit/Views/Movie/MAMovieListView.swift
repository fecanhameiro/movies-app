//
//  MAMovieListView.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import UIKit

protocol MAMovieListViewDelegate: AnyObject {
    func maMovieListView(
        _ movieListView: MAMovieListView,
        didSelectMovie movie: MAMovie
    )
}

/// View that handles showing list of characters, loader, etc.
final class MAMovieListView: UIView {
    
    public weak var delegate: MAMovieListViewDelegate?
    
    private let viewModel = MAMovieListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MAMovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: MAMovieCollectionViewCell.cellIdentifier)
        collectionView.register(MAFooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: MAFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView, spinner)
        addConstraints()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacters()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
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
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension MAMovieListView: MAMovieListViewViewModelDelegate {
    func didSelectMovie(_ movie: MAMovie) {
        delegate?.maMovieListView(self, didSelectMovie: movie)
    }
    
    func didLoadInitialMovies() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData() // Initial fetch
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didLoadMoreMovies(with newIndexPaths: [IndexPath]) {
        
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
}

