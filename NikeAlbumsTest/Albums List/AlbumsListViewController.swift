//
//  AlbumsListViewController.swift
//  NikeAlbumsTest
//
//  Created by Nate Potter on 1/11/21.
//

import UIKit
import Combine

// ViewController must conform to this protocol to revieve the viewModel from the presenter class
protocol AlbumsListDisplayable {
    func display(viewModel: AlbumsModels.ViewModel)
    func display(error: Error)
}

enum Section: CaseIterable {
    case main
}

class AlbumsListViewController: UIViewController, AlbumsListDisplayable {
    
    let customView = AlbumListView()
    
    var interactor: AlbumsListInteractor?
                
    var viewModel: AlbumsModels.ViewModel?
    
    lazy var cellConfig: UICollectionView.CellRegistration<UICollectionViewListCell, AlbumsModels.DisplayAlbum> = {
        UICollectionView.CellRegistration<UICollectionViewListCell, AlbumsModels.DisplayAlbum> { cell, indexPath, model in
            var config = AlbumCellContentConfiguration()
            config.name = model.name
            config.artist = model.artist
            config.image = model.thumbnail
            config.cancellable?.cancel()
            
            if model.thumbnail == nil {
                config.cancellable = ImageLoader.shared.loadImage(path: model.albumArtworkUrl)
                .catch{ error in return Just(nil) }
                .sink(receiveValue: { image in
                    if let album = self.dataSource.itemIdentifier(for: indexPath) {
                        var updatedModel = album
                        updatedModel.thumbnail = image
                        var newSnapshot = self.dataSource.snapshot()
                        newSnapshot.insertItems([updatedModel], beforeItem: album)
                        newSnapshot.deleteItems([album])
                        self.dataSource.apply(newSnapshot, animatingDifferences: false)
                    }
                })
            }
            
            cell.accessories = [.disclosureIndicator()]
            cell.contentConfiguration = config
        }
    }()
    
    lazy var dataSource = {
        UICollectionViewDiffableDataSource<Section, AlbumsModels.DisplayAlbum>(collectionView: customView.collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: self.cellConfig, for: indexPath, item: item)
        }
    }()
    
    override func loadView() {
        view = customView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        interactor = AlbumsListInteractor(library: Library(client: Client()))
        interactor?.presenter = AlbumsListPresenter(viewController: self)

        navigationItem.title = NSLocalizedString("albums.list.title", comment: "ViewController Title")
        
        customView.collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.collectionView.dataSource = dataSource
        
        // with more time I would construct the path with url componenet parameters
        interactor?.fetch(request: AlbumsModels.Request(url: "/us/apple-music/top-albums/all/100/explicit.json"))
    }
    
    func display(viewModel: AlbumsModels.ViewModel) {
        self.viewModel = viewModel
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, AlbumsModels.DisplayAlbum>()
        snapshot.appendSections(Section.allCases)
        
        snapshot.appendItems(viewModel.albums, toSection: .main)
        
        dataSource.apply(snapshot)
    }
    
    func display(error: Error) {
        let alertController = UIAlertController(title: "albums.common.whoops", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "albums.common.OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

extension AlbumsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let album = dataSource.itemIdentifier(for: indexPath) {
            let viewController = AlbumDetailViewController(album: album)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
