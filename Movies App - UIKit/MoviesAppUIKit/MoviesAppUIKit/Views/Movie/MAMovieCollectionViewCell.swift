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
    private var maskLayer: CAShapeLayer?
    
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
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, titleLabel, ratingLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpLayer()
    }
    
    private func setUpLayer() {
        
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
        
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowOffset = CGSize(width: -4, height: 4)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            ratingLabel.heightAnchor.constraint(equalToConstant: 30),
            ratingLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            ratingLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
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
        ratingLabel.text = nil
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
        
//        viewModel.fetchRating{ [weak self] result in
//            switch result {
//                case .success(let data):
//
//                    DispatchQueue.main.async {
//                        let ratingText = "IMDB:"
//
//                        if let imdb = data.imDb, data.imDb != ""
//                        {
//                            self?.ratingLabel.text = "\(ratingText) \(imdb)"
//                        }
//                        else
//                        {
//                            self?.ratingLabel.text = "\(ratingText) -"
//                        }
//                    }
//                case .failure(let error):
//                    print(String(describing: error))
//                    break
//            }
//        }
    }
}
