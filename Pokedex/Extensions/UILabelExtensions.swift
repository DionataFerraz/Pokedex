//
//  UILabelExtensions.swift
//  Pokedex
//
//  Created by Dionata Leonel Machado Ferraz on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

extension UILabel {
    
    func textMask(from idString: String) {
        self.text = String(format: "#%03d", Int(idString)!)
    }
    
   func textCapitalized(from name: String) {
        self.text = name.capitalized
    }
}
