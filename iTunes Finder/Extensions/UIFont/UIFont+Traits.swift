//
//  UIFont+Traits.swift
//  iTunes Finder
//
//  Created by Vladislav Len on 27.12.2020.
//

import UIKit

extension UIFont {
    
    // MARK: - Public Methods
    
    // Applies a bold font style.
    func bold() -> UIFont {
        return self.withSymbolicTraits(.traitBold)
    }
    
    // Applies an italic font style.
    func italic() -> UIFont {
        return self.withSymbolicTraits(.traitItalic)
    }
    
    // MARK: - Private Methods
    
    // Takes the font we are extending and applies the specified traits to it.
    // The size parameter in returning UIFont is set to zero, which means
    // don’t change the font size from what it currently is.
    private func withSymbolicTraits(_ symbolicTraits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let fontDescriptor = fontDescriptor.withSymbolicTraits(symbolicTraits) else { return self }
        let font = UIFont(descriptor: fontDescriptor, size: .zero)
        
        return font
    }
    
}
