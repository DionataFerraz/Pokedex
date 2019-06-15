//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Dionata Leonel Machado Ferraz on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonTypeView: PokemonTypeView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gradientView: GradientView!
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var pokemonImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageViewCenterVertically: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageViewTopConstraint: NSLayoutConstraint!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To accessibility
        view.accessibilityIdentifier = "detailView"
        
        self.initialConfig()
        
        if let type = pokemon?.types.first {
            
            self.pokemonTypeView.config(type: type)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       self.loadPokemonAnimations()
        requestPokemon()
    }
    
    func loadPokemonAnimations() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.imageView.alpha = 0.2
        })
    }
    
    func requestPokemon() {
        if let pokemon = self.pokemon {
            let requestMaker = RequestMaker()
            
            requestMaker.make(withEndpointUrl: .details(query: pokemon.id)) { (pokemon: Pokemon) in
                self.animateImagePokemonToTop()
            }
        }
    }
    
    func animateImagePokemonToTop() {
        DispatchQueue.main.async {
            self.imageView.layer.removeAllAnimations()
            
            self.pokemonImageViewCenterVertically.priority = UILayoutPriority(rawValue: 900)
            self.pokemonImageViewTopConstraint.priority =
                UILayoutPriority(rawValue: 999)
            
            self.pokemonImageViewHeightConstraint.constant = 80
            self.pokemonImageViewWidthConstraint.constant = 80
//            self.pokemonImageViewCenterVertically.constant = 80
//            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 1, animations: {
                self.imageView.alpha = 1
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func initialConfig() {
        if let pokemon = self.pokemon {
            self.gradientView.startColor = pokemon.types.first?.color ?? .black
            self.gradientView.endColor = pokemon.types.first?.color?.lighter() ?? .white
            
            self.imageView.loadImage(from: pokemon.image)
        }
    }
}
