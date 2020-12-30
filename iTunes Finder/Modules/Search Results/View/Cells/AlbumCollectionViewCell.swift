//
//  SearchCollectionViewCell.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 25.12.2020.
//

import UIKit
import TinyConstraints
import Nuke

final class AlbumCollectionViewCell: UICollectionViewCell, ConfigurableView {
    
    // MARK: - Public Properties
    
    static let identifier = "AlbumCollectionViewCell"
    
    // MARK: - Private Properties
    
    private let artworkImageView: UIImageView = {
        let artworkImageView = UIImageView()
        artworkImageView.contentMode = .scaleAspectFit
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            artworkImageView.backgroundColor = .systemGray6
        } else {
            artworkImageView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
        }
        
        return artworkImageView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = .medium
        } else {
            activityIndicatorView.style = .gray
        }
        
        return activityIndicatorView
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
    
    // MARK: - UICollectionViewCell Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Resets properties before reusing it
        self.artworkImageView.image = nil
        self.activityIndicatorView.startAnimating()
    }
    
    // MARK: - Public Methods
    
    // Configures a cell with data from a model.
    func configure(with model: Album) {
        // Loading an album artwork image
        if let url = URL(string: model.artworkUrl) {
            let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.33))
            Nuke.loadImage(with: url, options: options, into: artworkImageView) { [weak self] _ in
                self?.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    // MARK: - Layout
    
    // Groups all methods that are configuring the view.
    private func configureViews() {
        configureArtworkImageView()
        configureActivityIndicatorView()
    }
    
    // Configures an image view for an album artwork image.
    private func configureArtworkImageView() {
        self.contentView.addSubview(artworkImageView)
        
        // Setting up constraints
        artworkImageView.horizontalToSuperview()
        artworkImageView.verticalToSuperview()
    }
    
    // Configures an activity indicator to display an image loading process.
    private func configureActivityIndicatorView() {
        self.contentView.addSubview(activityIndicatorView)
        
        // Setting up constraints
        activityIndicatorView.centerXToSuperview()
        activityIndicatorView.centerYToSuperview()
    }
    
}
