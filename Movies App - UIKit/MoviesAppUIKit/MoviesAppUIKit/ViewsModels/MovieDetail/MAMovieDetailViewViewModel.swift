//
//  MAMovieDetailViewViewModel.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 19/05/23.
//

import UIKit

protocol MAMovieDetailViewViewModelDelegate: AnyObject {
    func didLoadMovieDetails()
}

final class MAMovieDetailViewViewModel {
    
    public weak var delegate: MAMovieDetailViewViewModelDelegate?
    
    private var movieDetails: MAMovieDetails?
    private let movieId: String
    private var movieTitle: String = "Details"
    
    /// Fetch initial set of movies
    public func fetchMovieDetail() {
        
        let request = MARequest(endpoint: .movieDetails, pathComponents: [self.movieId, "FullCast"])
        
        MAService.shared.execute(request,
            expecting: MAMovieDetails.self
        ) { [weak self] result in
            switch result {
                case .success(let model):
                    self?.movieDetails = model
                    DispatchQueue.main.async {
                        self?.setUpSections()
                        self?.delegate?.didLoadMovieDetails()
                    }
                case .failure(let error):
                    print(String(describing: error))
            }
        }
    }
    
    public var cast: [String] = []
    
    enum SectionType {
        case photo(viewModel: MAMoviePhotoCollectionViewCellViewModel)
        
        case information(viewModels: [MAMovieInfoCollectionViewCellViewModel])
        
        case plot(viewModel: MAMoviePlotCollectionViewCellViewModel)
                
        case fullCast(viewModels: [MAMovieCastCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
    // MARK: - Init
    
    init(movieId: String, movieTitle: String) {
        self.movieId = movieId
        self.movieTitle = movieTitle
    }
    
    private func setUpSections() {
        
        var fullCastViewModels: [MAMovieCastCollectionViewCellViewModel] = []
        
        var releaseDate = movieDetails?.releaseDate ?? ""
        if let date = MAMovieInfoCollectionViewCellViewModel.dateFormatter.date(from:  movieDetails?.releaseDate ?? "") {
            releaseDate = MAMovieInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        
        //Directors Cast
        fullCastViewModels.append(contentsOf: movieDetails?.fullCast?.directors?.items?.compactMap ({
            return MAMovieCastCollectionViewCellViewModel(title: movieDetails?.fullCast?.directors?.job, name: $0.name, castImageUrl: nil)
        }) ?? [])
        
        //Actors Cast
        fullCastViewModels.append(contentsOf: movieDetails?.fullCast?.actors?.compactMap ({
            return MAMovieCastCollectionViewCellViewModel(title: $0.name, name: $0.asCharacter, castImageUrl: URL(string: $0.image ?? ""))
        }) ?? [])
        
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string: movieDetails?.image ?? ""))),
            .information(viewModels: [
                .init(type: .title , value: movieDetails?.title ?? "-"),
                .init(type: .releaseDate , value: releaseDate)
            ]),
            .plot(viewModel: .init(text: movieDetails?.plot ?? "-")),
            .fullCast(viewModels: fullCastViewModels)
        ]
    }
    

    
    public var title: String {
        movieTitle.uppercased()
    }
    
    // MARK: - Layouts
    
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 0,
                                                     bottom: 10,
                                                     trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(UIDevice.isiPhone ? 0.5 : 0.25),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(90)
            ),
            subitems: UIDevice.isiPhone ? [item, item] : [item, item, item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createPlotSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 0,
                                                     bottom: 10,
                                                     trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
    public func createCastSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 5,
            bottom: 10,
            trailing: 8
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(UIDevice.isiPhone ? 0.8 : 0.4),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
