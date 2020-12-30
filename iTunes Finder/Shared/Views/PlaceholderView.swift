//
//  PlaceholderView.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 27.12.2020.
//

import UIKit

final class PlaceholderView: UIView {
    
    // MARK: - Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2).bold()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            titleLabel.textColor = .label
        } else {
            titleLabel.textColor = .black
        }
        
        return titleLabel
    }()
    
    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.font = .preferredFont(forTextStyle: .body)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 3
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            subtitleLabel.textColor = .label
        } else {
            subtitleLabel.textColor = .black
        }
        
        return subtitleLabel
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
    
    init(image: UIImage?, title: String, subtitle: String) {
        self.init()
        
        self.imageView.image = image
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
    }
    
    // MARK: - Layout
    
    // Groups all methods that are configuring the view.
    private func configureViews() {
        configureTitleLabel()
        configureSubtitleLabel()
        configureImageView()
    }
    
    // Configures a label with placeholder title.
    private func configureTitleLabel() {
        self.addSubview(titleLabel)
        
        // Setting up constraints
        titleLabel.centerYToSuperview()
        titleLabel.horizontalToSuperview(insets: .horizontal(32))
    }
    
    // Configures a label with placeholder subtitle.
    private func configureSubtitleLabel() {
        self.addSubview(subtitleLabel)
        
        // Setting up constraints
        subtitleLabel.topToBottom(of: titleLabel, offset: 8)
        subtitleLabel.horizontalToSuperview(insets: .horizontal(32))
    }
    
    // Configures an image view for placeholder image.
    private func configureImageView() {
        self.addSubview(imageView)
        
        // Setting up constraints
        imageView.horizontalToSuperview(insets: .horizontal(32))
        imageView.bottomToTop(of: titleLabel, offset: -16)
        imageView.aspectRatio(2 / 1)
    }
    
}
