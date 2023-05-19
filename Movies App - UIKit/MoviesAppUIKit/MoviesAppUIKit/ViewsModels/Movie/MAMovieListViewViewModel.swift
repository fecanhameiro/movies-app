//
//  MAMovieListViewViewModelDelegate.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import UIKit

protocol MAMovieListViewViewModelDelegate: AnyObject {
    func didLoadInitialMovies()
    func didSelectMovie(_ movie: MAMovie)
}

/// View Model to handle movie  list view logic
final class MAMovieListViewViewModel: NSObject {
    
    public weak var delegate: MAMovieListViewViewModelDelegate?
        
    private var movies: [MAMovie] = [] {
        didSet {
            for movie in movies {
                let viewModel = MAMovieCollectionViewCellViewModel(
                    movieId: movie.id,
                    movieTitle: movie.title,
                    movieImageUrl: URL(string: movie.image)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [MAMovieCollectionViewCellViewModel] = []
    
    
    /// Fetch initial set of movies
    public func fetchMovies() {
        MAService.shared.execute(
            .listMoviesRequests,
            expecting: MAGetMoviesResponse.self
        ) { [weak self] result in
            switch result {
                case .success(let responseModel):
                    self?.movies = responseModel.results
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadInitialMovies()
                    }
                case .failure(let error):
                    print(String(describing: error))
            }
        }
    }
    
}

// MARK: - CollectionView

extension MAMovieListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MAMovieCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? MAMovieCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MAFooterLoadingCollectionReusableView.identifier,
                for: indexPath
              ) as? MAFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = collectionView.bounds
        let width: CGFloat
        if UIDevice.isiPhone {
            width = (bounds.width-30)/2
        } else {
            // mac | ipad
            width = (bounds.width-50)/4
        }
        
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        delegate?.didSelectMovie(movie)
    }
}
