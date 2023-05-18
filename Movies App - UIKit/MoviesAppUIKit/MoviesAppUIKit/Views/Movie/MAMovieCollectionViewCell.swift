//
//  MAMovieCollectionViewCell.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 18/05/23.
//

import Foundation

import UIKit

/// Single cell for a movie
final class MAMovieCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "MAMovieCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
 
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, titleLabel)
        addConstraints()
        setUpLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            

            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            
            titleLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -3),
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
    }
    
    public func configure(with viewModel: MAMovieCollectionViewCellViewModel) {
        titleLabel.text = viewModel.movieTitle
        viewModel.fetchImage { [weak self] result in
            switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self?.imageView.image = image
                    }
                case .failure(let error):
                    print(String(describing: error))
                    break
            }
        }
    }
}
