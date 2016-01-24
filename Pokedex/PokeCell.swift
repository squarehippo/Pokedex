//
//  PokeCell.swift
//  Pokedex
//
//  Created by Brian Wilson on 1/23/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit

@IBDesignable
class PokeCell: UICollectionViewCell {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)     
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalizedString
        thumbImage.image = UIImage(named: String(self.pokemon.pokedexId))
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
                layer.borderColor = borderColor.CGColor
        }
    }
        
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
        
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
        

    
}
