//
//  MAMovieListViewViewModelDelegate.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import UIKit

protocol MAMovieListViewViewModelDelegate: AnyObject {
    func didLoadedMovies()
    func didSelectMovie(_ movie: MAMovie)
    func didStartLoadingMovies()
    func shouldShowEmptyMessage(_ show: Bool)
    func showErrorMessage(_ message: String)
    
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
                    movieImageUrl: URL(string: movie.image),
                    rating: MARating(imDbId: nil, imDb: movie.imDbRating)
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
        
        self.cellViewModels = []
        delegate?.didStartLoadingMovies()
        
        MAService.shared.execute(
            .listMostPopularMoviesRequests,
            expecting: MAGetMostPopularMoviesResponse.self
        ) { [weak self] result in
            switch result {
                case .success(let responseModel):
                    self?.movies = responseModel.items
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadedMovies()
                        self?.delegate?.shouldShowEmptyMessage(self?.movies.isEmpty ?? true)
                    }
                case .failure(let error):
                    print(String(describing: error))
                    self?.delegate?.showErrorMessage("error-message-movie-top".localized())
            }
        }
    }
    
    /// Fetch search movies
    public func fetchSearchMovies(searchText: String) {
        
        guard let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("Error encoding searchText")
            self.delegate?.showErrorMessage("error-message-movie-search-text".localized())
            return
        }
        
        self.cellViewModels = []
        delegate?.didStartLoadingMovies()
        
        let request = MARequest(endpoint: .movieSearch, pathComponents: [encodedSearchText])
        
        MAService.shared.execute(
            request,
            expecting: MAGetMoviesResponse.self
        ) { [weak self] result in
            switch result {
                case .success(let responseModel):
                    self?.movies = responseModel.results
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadedMovies()
                        self?.delegate?.shouldShowEmptyMessage(self?.movies.isEmpty ?? true)
                    }
                case .failure(let error):
                    print(String(describing: error))
                    self?.delegate?.showErrorMessage("error-message-movie-search".localized())
            }
        }
    }
    
 
    
}

// MARK: - CollectionView

extension MAMovieListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let searchText = searchBar.text {
            fetchSearchMovies(searchText: searchText)
        }
    }
    
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
        
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMHeaderSearchCollectionReusableView.identifier,
                for: indexPath
              ) as? RMHeaderSearchCollectionReusableView else {
            fatalError("Unsupported")
        }
        header.searchBar.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        delegate?.didSelectMovie(movie)
    }
}
