//
//  ViewController.swift
//  Pokedex
//
//  Created by Juliano Nardon on 07/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

protocol PokemonListViewType: AnyObject {
    func reloadData()
}

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIView!
    
    private let presenter = PokemonListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.configTable()
        self.presenter.view = self
        self.presenter.fetchData()
    }
    
    private func configTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = presenter
    }
}

extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = self.storyboard
        
        if let detailViewController =
            storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailViewController.pokemon = self.presenter.pokemon(at: indexPath.row)
            
            self.navigationController?.present(detailViewController, animated: true)
        }
    }
}

extension PokemonListViewController: PokemonListViewType {
    func reloadData() {
        self.activityIndicatorView.isHidden = true
        self.tableView.reloadData()
    }
}