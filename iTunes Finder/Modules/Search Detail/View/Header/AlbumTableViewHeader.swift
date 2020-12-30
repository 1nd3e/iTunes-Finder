//
//  AlbumTableViewHeader.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 30.12.2020.
//

import UIKit
import Nuke
import TinyConstraints

final class AlbumTableViewHeader: UITableViewHeaderFooterView, ConfigurableView {
    
    // MARK: - Public Properties
    
    static let identifier = "AlbumTableViewHeader"
    
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
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        nameLabel.numberOfLines = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            nameLabel.textColor = .label
        } else {
            nameLabel.textColor = .black
        }
        
        return nameLabel
    }()
    
    private let artistNameLabel: UILabel = {
        let artistNameLabel = UILabel()
        artistNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            artistNameLabel.textColor = .label
        } else {
            artistNameLabel.textColor = .black
        }
        
        return artistNameLabel
    }()
    
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            priceLabel.textColor = .secondaryLabel
        } else {
            priceLabel.textColor = .gray
        }
        
        return priceLabel
    }()
    
    private let currencyLabel: UILabel = {
        let currencyLabel = UILabel()
        currencyLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            currencyLabel.textColor = .secondaryLabel
        } else {
            currencyLabel.textColor = .gray
        }
        
        return currencyLabel
    }()
    
    // MARK: - Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureViews()
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
        
        // Setting content
        nameLabel.text = model.name
        artistNameLabel.text = model.artistName
        priceLabel.text = model.price
        currencyLabel.text = model.currency
    }
    
    // MARK: - Layout
    
    // Groups all methods that are configuring the view.
    private func configureViews() {
        configureContentView()
        configureArtworkImageView()
        configureActivityIndicatorView()
        configureNameLabel()
        configureArtistNameLabel()
        configurePriceView()
    }
    
    // Configures a content view.
    private func configureContentView() {
        self.contentView.verticalToSuperview()
        self.contentView.horizontalToSuperview()
    }
    
    // Configures an image view for an album artwork image.
    private func configureArtworkImageView() {
        self.contentView.addSubview(artworkImageView)
        
        // Setting up constraints
        self.contentView.top(to: artworkImageView, offset: -20)
        artworkImageView.leftToSuperview(offset: 20)
        artworkImageView.widthToSuperview(multiplier: 0.5)
        artworkImageView.aspectRatio(1)
    }
    
    // Configures an activity indicator to display an image loading process.
    private func configureActivityIndicatorView() {
        self.contentView.addSubview(activityIndicatorView)
        
        // Setting up constraints
        activityIndicatorView.centerX(to: artworkImageView)
        activityIndicatorView.centerY(to: artworkImageView)
    }
    
    // Configures a label to display an album name.
    private func configureNameLabel() {
        self.contentView.addSubview(nameLabel)
        
        // Setting up constraints
        nameLabel.topToBottom(of: artworkImageView, offset: 16)
        nameLabel.horizontalToSuperview(insets: .horizontal(20))
    }
    
    // Configures a label to display an artist name of the album.
    private func configureArtistNameLabel() {
        self.contentView.addSubview(artistNameLabel)
        
        // Setting up constraints
        artistNameLabel.topToBottom(of: nameLabel)
        artistNameLabel.horizontalToSuperview(insets: .horizontal(20))
    }
    
    // Configures a view to display an album price.
    private func configurePriceView() {
        // Creating a Stack View for placing a price labels
        let priceStackView = UIStackView()
        priceStackView.axis = .horizontal
        priceStackView.alignment = .center
        priceStackView.distribution = .fill
        priceStackView.spacing = 4
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(priceStackView)
        
        // Placing labels in the Stack View
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(currencyLabel)
        
        // Setting up constraints
        priceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        currencyLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        priceStackView.topToBottom(of: artistNameLabel, offset: 8)
        priceStackView.horizontalToSuperview(insets: .horizontal(20))
        self.contentView.bottom(to: priceStackView, offset: 16)
    }
    
}
