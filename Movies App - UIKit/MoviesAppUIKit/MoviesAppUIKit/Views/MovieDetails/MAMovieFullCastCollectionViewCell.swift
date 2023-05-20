//
//  MAMovieFullCastCollectionViewCell.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 19/05/23.
//

import UIKit
import SDWebImage

class MAMovieFullCastCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "MAMovieFullCastCollectionViewCell"
    private var maskLayer: CAShapeLayer?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sd_imageTransition = .fade
        return imageView
    }()
    
    private let spinnerImage: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        setUpLayer()
        contentView.addSubviews(titleLabel, nameLabel, imageView, spinnerImage)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpLayer() {
        contentView.layer.borderWidth = 2
        
        if let maskLayer = self.maskLayer {
            maskLayer.frame = bounds
            maskLayer.path = UIBezierPath(roundedRect: bounds,
                                          byRoundingCorners: [.allCorners],
                                          cornerRadii: CGSize(width: 8.0, height: 8.0)).cgPath
        } else {
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = UIBezierPath(roundedRect: bounds,
                                          byRoundingCorners: [.allCorners],
                                          cornerRadii: CGSize(width: 8.0, height: 8.0)).cgPath
            contentView.layer.mask = maskLayer
            self.maskLayer = maskLayer
        }
        
    
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            spinnerImage.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            spinnerImage.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        nameLabel.text = nil
        imageView.image = nil
    }
    
    public func configure(with viewModel: MAMovieCastCollectionViewCellViewModel) {
        
        DispatchQueue.main.async {
            self.titleLabel.text = viewModel.title
            self.nameLabel.text = viewModel.name
        }
        
        if let imageUrl = viewModel.castImageUrl {
            spinnerImage.startAnimating()
            
            imageView.sd_setImage(with: imageUrl, placeholderImage: nil, options: []) { [weak self] (_, _, _, _) in
                DispatchQueue.main.async {
                    self?.spinnerImage.stopAnimating()
                    self?.spinnerImage.removeFromSuperview()
                }
            }
        }
        
    }
}
