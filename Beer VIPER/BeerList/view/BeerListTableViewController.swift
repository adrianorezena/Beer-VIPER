//
//  ViewController.swift
//  Beer VIPER
//
//  Created by Adriano on 11/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import UIKit
import Kingfisher

class BeerListTableViewController: UITableViewController {

    var presenter: BeerListViewToPresenterProtocol?
    var beers: [BeerListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter?.updateView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let beer = beers[indexPath.row]
        
        cell.detailTextLabel?.text = beer.tagline
        cell.textLabel?.text = beer.name
        cell.imageView?.kf.indicatorType = .activity
        
        if let url = URL(string: beer.image_url) {
            cell.imageView?.kf.setImage(with: url)
        } else {
            cell.imageView?.image = UIImage(named: "placeholder")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = beers[indexPath.row]
        presenter?.showDetails(beer: beer)
    }
    
}

extension BeerListTableViewController: BeerListPresenterToViewProtocol {
    
    func showBeers(beers: [BeerListModel]) {
        self.beers = beers
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Error when fetching beers", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)        
    }
    
}
