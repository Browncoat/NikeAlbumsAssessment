//
//  AlbumCellContentView.swift
//  NikeAlbumsTest
//
//  Created by Nate Potter on 1/11/21.
//

import UIKit
import Combine

// Creating a custom contentView for the UICollectionViewListCell with a cancellable property to retain a reference to the downloading thumbnail image
struct AlbumCellContentConfiguration: UIContentConfiguration, Hashable {
    var name: String?
    var artist: String?
    var image: UIImage?
    var cancellable: AnyCancellable?
    
    func makeContentView() -> UIView & UIContentView {
        return AlbumCellContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> AlbumCellContentConfiguration {
        return self
    }
}

class AlbumCellContentView: UIView, UIContentView {
    private var currentConfiguration: AlbumCellContentConfiguration!
    var configuration: UIContentConfiguration {
        get {
            currentConfiguration
        }
        set {
            guard let newConfiguration = newValue as? AlbumCellContentConfiguration else {
                return
            }
            
            apply(configuration: newConfiguration)
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView = UIImageView()
    
    init(configuration: AlbumCellContentConfiguration) {
        super.init(frame: .zero)
        
        setupUI()
        
        apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameLabel)
        addSubview(artistLabel)
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            artistLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 1),
            artistLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            artistLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            artistLabel.lastBaselineAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func apply(configuration: AlbumCellContentConfiguration) {
        guard currentConfiguration != configuration else {
            return
        }
        
        currentConfiguration = configuration
        
        nameLabel.text = configuration.name
        artistLabel.text = configuration.artist
        imageView.image = configuration.image
    }
}
