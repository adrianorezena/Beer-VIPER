//
//  FavoritesViewController.swift
//  Beer VIPER
//
//  Created by Adriano on 11/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import UIKit

class FavoriteBeersTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initUIElements()
    }
    
    func initUIElements() {
        //tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "BeerTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")        
    }
    

}
