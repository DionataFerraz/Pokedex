//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Dionata Leonel Machado Ferraz on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var primaryTypeImageView: UIImageView!
    @IBOutlet weak var secondaryTypeImageView: UIImageView!
    
    func config(with model: Pokemon) {
        pictureImageView.loadImage(from: model.image)
        nameLabel.textCapitalized(from: model.name)
        idLabel.textMask(from: model.id)
        
        DispatchQueue.main.async {
            self.primaryTypeImageView.backgroundColor = model.types.first?.color
            self.primaryTypeImageView.image = model.types.first?.icon
        
            if model.types.count > 1 {
                self.secondaryTypeImageView.image = model.types[1].icon
                self.secondaryTypeImageView.backgroundColor = model.types[1].color
                self.secondaryTypeImageView.isHidden = false
            } else {
                self.secondaryTypeImageView.isHidden = true
            }
        }
    }
}
