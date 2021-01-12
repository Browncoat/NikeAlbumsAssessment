//
//  AlbumDetailView.swift
//  NikeAlbumsTest
//
//  Created by Nate Potter on 1/11/21.
//

import UIKit

class AlbumDetailView: UIView {
    static var largeTitleLabel: UILabel {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static var subHeadlineLabel: UILabel {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static var titleLabel: UILabel {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static var bodyLabel: UILabel {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = AlbumDetailView.largeTitleLabel
        label.numberOfLines = 0
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = AlbumDetailView.subHeadlineLabel
        return label
    }()
    
    let genresTitleLabel: UILabel = {
        let label = AlbumDetailView.titleLabel
        label.text = NSLocalizedString("albums.detail.genres-title", comment: "")
        return label
    }()
    
    let genresLabel: UILabel = {
        let label = AlbumDetailView.bodyLabel
        return label
    }()
    
    let releaseDateTitleLabel: UILabel = {
        let label = AlbumDetailView.titleLabel
        label.text = NSLocalizedString("albums.detail.release-date-title", comment: "")
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = AlbumDetailView.bodyLabel
        return label
    }()
    
    let copyrightTitleLabel: UILabel = {
        let label = AlbumDetailView.titleLabel
        label.text = NSLocalizedString("albums.detail.copyright-title", comment: "")
        return label
    }()
    
    let copyrightLabel: UILabel = {
        let label = AlbumDetailView.bodyLabel
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("albums.detail.button-title", comment: ""), for: .normal)
        return button
    }()
    
    let padding: CGFloat = 20
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundColor = .systemBackground
        
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(artistLabel)
        contentView.addSubview(genresTitleLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(releaseDateTitleLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(copyrightTitleLabel)
        contentView.addSubview(copyrightLabel)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: button.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 1.5),
            nameLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            artistLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 1),
            artistLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            artistLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            genresTitleLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: artistLabel.bottomAnchor, multiplier: 1.5),
            genresTitleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            genresTitleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            genresLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: genresTitleLabel.bottomAnchor, multiplier: 1),
            genresLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            genresLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            releaseDateTitleLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: genresLabel.bottomAnchor, multiplier: 1.5),
            releaseDateTitleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            releaseDateTitleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            releaseDateLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: releaseDateTitleLabel.bottomAnchor, multiplier: 1),
            releaseDateLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            copyrightTitleLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: releaseDateLabel.bottomAnchor, multiplier: 1.5),
            copyrightTitleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            copyrightTitleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            copyrightLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: copyrightTitleLabel.bottomAnchor, multiplier: 1),
            copyrightLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            copyrightLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            copyrightLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            button.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            button.heightAnchor.constraint(equalToConstant: 44),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
}
