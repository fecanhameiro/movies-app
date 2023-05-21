//
//  MAMoviePhotoCollectionViewCell.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 19/05/23.
//

import Foundation
import UIKit

///  This class is a UICollectionViewCell subclass that manages the display of a movie photo within a collection view.
final class MAMoviePhotoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "MAMoviePhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isAccessibilityElement = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let spinnerImage: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(spinnerImage)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            spinnerImage.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            spinnerImage.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    public func configure(with viewModel: MAMoviePhotoCollectionViewCellViewModel) {
        
        self.spinnerImage.startAnimating()
        
        viewModel.fetchImage { [weak self] result in
            switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.spinnerImage.stopAnimating()
                        self?.imageView.image = UIImage(data: data)
                        self?.imageView.accessibilityLabel = viewModel.accessibilityText
                    }
                case .failure:
                    break
            }
        }
    }
}
