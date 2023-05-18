//
//  MATabBarController.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import UIKit

/// Controller to house tabs and root tab controllers
final class MATabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let moviesVC = MAMovieViewController()
        
        moviesVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: moviesVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Movies",
                                       image: UIImage(systemName: "film.stack"),
                                       tag: 1)
        
        for nav in [nav1] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [nav1],
            animated: true
        )
    }
}
