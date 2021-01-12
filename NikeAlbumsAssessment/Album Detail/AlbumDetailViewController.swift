//
//  AlbumDetailViewController.swift
//  NikeAlbumsTest
//
//  Created by Nate Potter on 1/11/21.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    let album: AlbumsModels.DisplayAlbum
    
    override func loadView() {
        view = AlbumDetailView()
    }
    
    init(album: AlbumsModels.DisplayAlbum) {
        self.album = album
        
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = album.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = view as? AlbumDetailView {
            view.imageView.image = album.thumbnail
            view.nameLabel.text = album.name
            view.artistLabel.text = album.artist
            view.genresLabel.text = album.genres
            view.copyrightLabel.text = album.copyright
            view.releaseDateLabel.text = album.releaseDate
            
            view.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
    }
    
    @objc func didTapButton(sender: UIButton) {
        if let url = URL(string: album.albumUrl), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        } else {
            let alertController = UIAlertController(title: "albums.openURL.error.app-not-installed", message: "", preferredStyle: .alert)
            present(alertController, animated: true)
            let action = UIAlertAction(title: NSLocalizedString("albums.common.OK", comment: ""), style: .default, handler: nil)
            alertController.addAction(action)
        }
    }
}
