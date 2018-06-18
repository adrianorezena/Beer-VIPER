//
//  FavoritesViewController.swift
//  Beer VIPER
//
//  Created by Adriano on 11/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteBeersTableViewController: UITableViewController {

    //MARK: - Properties
    var presenter: FavoriteBeersViewToPresenterProtocol?
    var favoriteBeers: [FavoriteBeer] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initUIElements()
        presenter?.updateView()
    }
    
    func initUIElements() {        
        tableView.register(UINib(nibName: "BeerTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")        
    }
    
    //MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteBeers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BeerTableViewCell
        
        let beer = favoriteBeers[indexPath.row]
        cell.beerTaglineLabel.text = beer.tagline
        cell.beerNameLabel.text = beer.name
        
        if let url = URL(string: beer.image_url) {
            cell.imageView?.contentMode = .scaleAspectFit
            cell.imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .progressiveDownload, completed: { (image, error, type, url) in
                cell.imageView?.setNeedsLayout()
            })
        } else {
            cell.imageView?.image = UIImage(named: "placeholder")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = self.favoriteBeers[indexPath.row]        
        presenter?.showDetails(favoriteBeer: beer)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {        
        
        let action = UITableViewRowAction(style: .default, title: "Remove from favorites") { (action, index) in
        
            let beer = self.favoriteBeers[indexPath.row]
            self.presenter?.removeFromFavorites(favoriteBeer: beer)
        }
        
        action.backgroundColor = .red
        return [action]
    }

    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
}


//MARK: - FavoriteBeersPresenterToViewProtocol
extension FavoriteBeersTableViewController: FavoriteBeersPresenterToViewProtocol {
    
    func showFavorites(favoriteBeers: [FavoriteBeer]) {
        self.favoriteBeers = favoriteBeers
        tableView.reloadData()
    }
    
}


//MARK: - BeerDetailsDelegate
extension FavoriteBeersTableViewController: BeerDetailsDelegate {
    
}
