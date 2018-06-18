//
//  BeerDetailsViewController.swift
//  Beer VIPER
//
//  Created by Adriano on 11/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    func showBeerDetails(beerName: String, beerTagline: String, beerDescription: String, beerImageURL: String) {
        nameLabel.text = beerName
        taglineLabel.text = beerTagline
        descriptionLabel.text = beerDescription
        
        if let url = URL(string: beerImageURL) {
            imageView?.contentMode = .scaleAspectFit
            imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .progressiveDownload, completed: { (image, error, type, url) in
                self.imageView?.setNeedsLayout()
            })
            
        } else {
            imageView?.image = UIImage(named: "placeholder")
        }
    }

}
