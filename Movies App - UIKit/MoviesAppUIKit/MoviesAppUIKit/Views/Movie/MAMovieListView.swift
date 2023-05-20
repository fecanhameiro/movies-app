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

/// View that handles showing list of movies, loader, etc.
final class MAMovieListView: UIView {
    
    public weak var delegate: MAMovieListViewDelegate?
    private var collectionView: UICollectionView!
    private let viewModel = MAMovieListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Nenhum filme encontrado com a sua pesquisa :("
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        return label
    }()

    
    private func createCollectionView() -> UICollectionView {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            RMHeaderSearchCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: RMHeaderSearchCollectionReusableView.identifier
        )
        collectionView.register(
            MAMovieCollectionViewCell.self,
            forCellWithReuseIdentifier: MAMovieCollectionViewCell.cellIdentifier
        )
        return collectionView
    }
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        collectionView = createCollectionView()
        addSubviews(collectionView, spinner, emptyLabel)
        addConstraints()
        viewModel.delegate = self
        setUpCollectionView()
        viewModel.fetchMovies()
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
            
            emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(12)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.boundarySupplementaryItems = [header]
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        
        return UICollectionViewCompositionalLayout(section: section)
    }


}

extension MAMovieListView: MAMovieListViewViewModelDelegate {
    func didSelectMovie(_ movie: MAMovie) {
        delegate?.maMovieListView(self, didSelectMovie: movie)
    }
    
    func didStartLoadingMovies() {
        spinner.startAnimating()
        shouldShowEmptyMessage(false)
        collectionView.reloadData() 
    }
    
    func didLoadedMovies() {
        spinner.stopAnimating()
        collectionView.reloadData() 
    }
    
    func shouldShowEmptyMessage(_ show: Bool) {
        
        UIView.animate(withDuration: 0.1) {
            self.emptyLabel.alpha = show ? 1 : 0
        }
    }
}

