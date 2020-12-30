//
//  ParsableModel.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 30.12.2020.
//

import Foundation

protocol ParsableModel {
    init?(data: Dictionary<String, Any>)
}
