//
//  ConfigurableView.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 26.12.2020.
//

import Foundation

protocol ConfigurableView {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
