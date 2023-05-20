//
//  MAMoviePlotCollectionViewCell.swift
//  MoviesAppUIKit
//
//  Created by Felipe C Canhameiro on 19/05/23.
//

import Foundation
import UIKit

final class MAMoviePlotCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "MAMoviePlotCollectionViewCell"
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .label
        textView.font = .systemFont(ofSize: 16, weight: .light)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = true;
        textView.isEditable = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(textView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.topAnchor),
            textView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            textView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textView.text = nil
    }
    
    public func configure(with viewModel: MAMoviePlotCollectionViewCellViewModel) {
        DispatchQueue.main.async {
            self.textView.text = viewModel.text;
        }
    }
}
