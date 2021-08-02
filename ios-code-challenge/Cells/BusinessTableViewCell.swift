//
//  BusinessTableViewCell.swift
//  ios-code-challenge
//
//  Created by Patrick Pahl on 8/1/21.
//  Copyright © 2021 Dustin Lange. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
    
    static let identifier = "BusinessTableViewCell"
    
    lazy var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    lazy var reviewCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    lazy var categoriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with cellModel: BusinessTableViewCellModel) {
        nameLabel.text = cellModel.business.name
        ratingLabel.text = cellModel.ratingText
        reviewCountLabel.text = cellModel.reviewCountText
        distanceLabel.text = cellModel.distanceText
        categoriesLabel.text = cellModel.categoriesText
        thumbnailImageView.imageFromServerURL(urlString: cellModel.business.image_url)
    }
    
    private func setUpView() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(reviewCountLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(categoriesLabel)
        
        let constraints = [
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 50),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 5),
            
            ratingLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            
            reviewCountLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 5),
            reviewCountLabel.topAnchor.constraint(equalTo: ratingLabel.topAnchor),
            
            distanceLabel.leadingAnchor.constraint(equalTo: reviewCountLabel.trailingAnchor, constant: 5),
            distanceLabel.topAnchor.constraint(equalTo: reviewCountLabel.topAnchor),
            
            categoriesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            categoriesLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 1),
            categoriesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
}
