//
//  String+Validation.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 30.12.2020.
//

import Foundation

extension String {
    
    // Verifies that a given string has a value.
    var isNotEmpty: Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedString.isEmpty {
            return false
        } else {
            return true
        }
    }
    
}
