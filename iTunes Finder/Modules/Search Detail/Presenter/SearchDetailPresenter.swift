//
//  SearchDetailPresenter.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 30.12.2020.
//

import UIKit

protocol SearchDetailViewProtocol: class {
    func shouldReloadData()
}

protocol SearchDetailPresenterProtocol {
    init(view: SearchDetailViewProtocol, router: SearchDetailRouterProtocol, album: Album)
    func fetchSongs()
}

final class SearchDetailPresenter: NSObject, SearchDetailPresenterProtocol {
    
    // MARK: - Properties
    
    private weak var view: SearchDetailViewProtocol?
    private let router: SearchDetailRouterProtocol
    
    private let album: Album
    private var songs: Array<Song> = [] {
        didSet {
            view?.shouldReloadData()
        }
    }
    
    // MARK: - Initializers
    
    init(view: SearchDetailViewProtocol, router: SearchDetailRouterProtocol, album: Album) {
        self.view = view
        self.router = router
        self.album = album
    }
    
    // MARK: - Methods
    
    // Fetches a song list of the album.
    func fetchSongs() {
        DataProvider.shared.get(songsWithAlbumId: album.id) { songs in
            self.songs = songs
        }
    }
    
}

// MARK: - UITableView Data Source

extension SearchDetailPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier, for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        
        let song = songs[indexPath.row]
        cell.configure(with: song)
        
        return cell
    }
    
}

// MARK: - UITableView Delegate

extension SearchDetailPresenter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 320
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Configures a header view to display detailed information about the album
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: AlbumTableViewHeader.identifier) as? AlbumTableViewHeader else { return UIView() }
        view.configure(with: album)
        
        return view
    }
    
}
