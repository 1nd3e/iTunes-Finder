//
//  SearchCollectionViewCell.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit
import TinyConstraints

final class AlbumCollectionViewCell: UICollectionViewCell, ConfigurableView {
    
    // MARK: - Public Properties
    
    static let identifier = "AlbumCollectionViewCell"
    
    // MARK: - Private Properties
    
    private let artworkImageView: UIImageView = {
        let artworkImageView = UIImageView()
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        artworkImageView.contentMode = .scaleAspectFit
        
        return artworkImageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureViews()
    }
    
    // MARK: - Public Methods
    
    // Configures a cell with data from a model.
    func configure(with model: Album) {}
    
    // MARK: - Layout
    
    // Groups all methods that are configuring the view.
    private func configureViews() {
        configureArtworkImageView()
    }
    
    // Configures an image view for an album artwork image.
    private func configureArtworkImageView() {
        self.contentView.addSubview(artworkImageView)
        
        // Setting up constraints
        artworkImageView.horizontalToSuperview()
        artworkImageView.verticalToSuperview()
    }
    
}
