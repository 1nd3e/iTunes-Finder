//
//  SearchHistoryTableViewCell.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 29.12.2020.
//

import UIKit

final class SearchHistoryTableViewCell: UITableViewCell, ConfigurableView {
    
    // MARK: - Public Properties
    
    static let identifier = "SearchHistoryTableViewCell"
    
    // MARK: - Private Properties
    
    private let queryLabel: UILabel = {
        let queryLabel = UILabel()
        queryLabel.font = UIFont.preferredFont(forTextStyle: .body)
        queryLabel.numberOfLines = 1
        queryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            queryLabel.textColor = .label
        } else {
            queryLabel.textColor = .black
        }
        
        return queryLabel
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
    func configure(with model: SearchItem) {
        queryLabel.text = model.query
    }
    
    // MARK: - Layout
    
    // Groups all methods that are configuring the view.
    private func configureViews() {
        configureQueryLabel()
    }
    
    // Configures a label.
    private func configureQueryLabel() {
        self.addSubview(queryLabel)
        
        // Setting up constraints
        queryLabel.centerYToSuperview()
        queryLabel.horizontalToSuperview(insets: .horizontal(20))
    }
    
}
