//
//  MAMovieViewController.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import UIKit

///  A UIViewController subclass that controls the interactions and data of the movie list view.
class MAMovieViewController: UIViewController, MAMovieListViewDelegate {

    private let movieListView = MAMovieListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "movie-list-title".localized()
        setUpView()
    }

    private func setUpView() {
        movieListView.delegate = self
        view.addSubview(movieListView)
        NSLayoutConstraint.activate([
            movieListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            movieListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            movieListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        movieListView.fetchMovies()
    }
    
    // MARK: - MAMovieListViewDelegate
    
    func maMovieListView(_ movieListView: MAMovieListView, didSelectMovie movie: MAMovie) {
        // Open detail controller for that movie
        let viewModel = MAMovieDetailViewViewModel(movieId: movie.id, movieTitle: movie.title)
        let detailVC = MAMovieDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func maMovieListViewShowError(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "error-message-movie-error".localized(), message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
