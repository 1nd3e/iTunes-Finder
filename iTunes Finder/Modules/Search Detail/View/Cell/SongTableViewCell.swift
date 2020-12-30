//
//  SongTableViewCell.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 30.12.2020.
//

import UIKit

final class SongTableViewCell: UITableViewCell, ConfigurableView {
    
    // MARK: - Public Properties
    
    static let identifier = "SongTableViewCell"
    
    // MARK: - Private Properties
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.numberOfLines = 1
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            nameLabel.textColor = .label
        } else {
            nameLabel.textColor = .black
        }
        
        return nameLabel
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureViews()
    }
    
    // MARK: - Public Methods
    
    // Configures a cell with data from a model.
    func configure(with model: Song) {
        nameLabel.text = model.name
    }
    
    // MARK: - Layout
    
    // Groups all methods that are configuring the view.
    private func configureViews() {
        configureNameLabel()
    }
    
    // Configures a label.
    private func configureNameLabel() {
        self.addSubview(nameLabel)
        
        // Setting up constraints
        nameLabel.centerYToSuperview()
        nameLabel.horizontalToSuperview(insets: .horizontal(20))
    }
    
}
