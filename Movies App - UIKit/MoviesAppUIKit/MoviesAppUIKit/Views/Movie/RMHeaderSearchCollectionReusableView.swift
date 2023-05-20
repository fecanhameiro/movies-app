//
//  RMHeaderSearchCollectionReusableView.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 20/05/23.
//

import UIKit

class RMHeaderSearchCollectionReusableView: UICollectionReusableView, UISearchBarDelegate {
    static let identifier = "RMHeaderSearchCollectionReusableView"
    var searchBar: UISearchBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        searchBar = UISearchBar(frame: self.bounds)
        searchBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        searchBar.placeholder = "Pesquisa pelo seu filme preferido"
        searchBar.delegate = self
        addSubview(searchBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
