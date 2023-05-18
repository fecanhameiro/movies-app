//
//  MAMovieListViewViewModelDelegate.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import UIKit

protocol MAMovieListViewViewModelDelegate: AnyObject {
    func didLoadInitialMovies()
    func didLoadMoreMovies(with newIndexPaths: [IndexPath])
    
    func didSelectMovie(_ movie: MAMovie)
}

/// View Model to handle movie  list view logic
final class MAMovieListViewViewModel: NSObject {
    
    public weak var delegate: MAMovieListViewViewModelDelegate?
    
    private var isLoadingMoreMovies = false
    
    private var movies: [MAMovie] = [] {
        didSet {
            for movie in movies {
                let viewModel = MAMovieCollectionViewCellViewModel(
                    movieTitle: movie.title,
                    movieImageUrl: URL(string: Constants.baseImageUrl + movie.posterPath)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [MAMovieCollectionViewCellViewModel] = []
    
    private var apiPage = 0
    private var apiTotalPages = 0
    
    /// Fetch initial set of movies (20)
    public func fetchMovies() {
        MAService.shared.execute(
            .listMoviesRequests,
            expecting: MAGetMoviesResponse.self
        ) { [weak self] result in
            switch result {
                case .success(let responseModel):
                    self?.movies = responseModel.results
                    self?.apiPage = responseModel.page
                    self?.apiTotalPages = responseModel.totalPages
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadInitialMovies()
                    }
                case .failure(let error):
                    print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional movies are needed
    public func fetchAdditionalMovies(url: URL) {
        guard !isLoadingMoreMovies else {
            return
        }
        isLoadingMoreMovies = true
        guard let request = MARequest(url: url) else {
            isLoadingMoreMovies = false
            return
        }
        
        MAService.shared.execute(request, expecting: MAGetMoviesResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
                case .success(let responseModel):
                    let moreResults = responseModel.results
                    
                    strongSelf.apiPage = responseModel.page
                    strongSelf.apiTotalPages = responseModel.totalPages
                    
                    let originalCount = strongSelf.movies.count
                    let newCount = moreResults.count
                    let total = originalCount+newCount
                    let startingIndex = total - newCount
                    let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                        return IndexPath(row: $0, section: 0)
                    })
                    strongSelf.movies.append(contentsOf: moreResults)
                    
                    DispatchQueue.main.async {
                        strongSelf.delegate?.didLoadMoreMovies(
                            with: indexPathsToAdd
                        )
                        
                        strongSelf.isLoadingMoreMovies = false
                    }
                case .failure(let failure):
                    print(String(describing: failure))
                    self?.isLoadingMoreMovies = false
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiPage < apiTotalPages
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
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        
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

// MARK: - ScrollView
extension MAMovieListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let nextUrlString = String(apiPage + 1)
        
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreMovies,
              !cellViewModels.isEmpty,
              let url = URL(string: nextUrlString) else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalMovies(url: url)
            }
            t.invalidate()
        }
    }
}
