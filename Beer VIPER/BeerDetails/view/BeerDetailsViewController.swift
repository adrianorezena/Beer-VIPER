//
//  BeerDetailsViewController.swift
//  Beer VIPER
//
//  Created by Adriano on 11/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import UIKit
import Kingfisher

class BeerDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var presenter: BeerDetailsViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.updateView()
    }
}


extension BeerDetailsViewController: BeerDetailsPresenterToViewProtocol {
    
    func showBeerDetails(beer: BeerListModel) {
        nameLabel.text = beer.name
        taglineLabel.text = beer.tagline
        descriptionLabel.text = beer.description
        
        if let url = URL(string: beer.image_url) {
            imageView?.kf.setImage(with: url)
        } else {
            imageView?.image = UIImage(named: "placeholder")
        }
    }

}
