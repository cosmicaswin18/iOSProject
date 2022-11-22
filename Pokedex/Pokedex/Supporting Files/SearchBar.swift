//
//  SearchBar.swift
//  Pokedex
//
//  Created by durgesh-10379 on 27/09/21.
//

import UIKit

class SearchBar: UISearchBar {
    var clearButtonImage: UIImage?
    var clearButtonColor: UIColor = .white
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let textField = self.value(forKey: "searchField") as? UITextField {
            if let clearButton = textField.value(forKey: "clearButton") as? UIButton {
                update(button: clearButton, image: self.clearButtonImage, color: clearButtonColor)
            }
        }
    }
    
    private func update(button: UIButton, image: UIImage?, color: UIColor) {
        let image = (image ?? button.currentImage)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
        button.tintColor = color
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
}
