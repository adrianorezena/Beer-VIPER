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

    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: - Properties
    private var searchController: UISearchController!
    var presenter: BeerListViewToPresenterProtocol?
    var beers: [BeerModel] = []
    var filteredBeers: [BeerModel] = []
    var searchBarActive: Bool = false
    var currentPage = 1
    var loading = false
    var emptyTableLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "main")
        label.text = "No results were found"
        return label
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initUIElements()
        presenter?.updateView()
    }
    

    func initUIElements() {
        tableView.register(UINib(nibName: "BeerTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        searchBar.delegate = self
        searchBar.showsScopeBar = true
    }
    
    
    //MARK: - TableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var beer: BeerModel!
        
        if isFiltering() {
            beer = filteredBeers[indexPath.row]
        } else {
            beer = beers[indexPath.row]
        }
        
        presenter?.showDetails(beer: beer)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredBeers.count
        } else {
            return beers.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BeerTableViewCell
        var beer: BeerModel
        
        if isFiltering() {
            beer = filteredBeers[indexPath.row]
            
            var attrString: NSAttributedString = highlightSearchResult(searchString: searchBar.text!, resultString: beer.name)
            cell.beerNameLabel.attributedText = attrString
            
            attrString = highlightSearchResult(searchString: searchBar.text!, resultString: beer.tagline)
            cell.beerTaglineLabel.attributedText = attrString
        } else {
            beer = beers[indexPath.row]
            cell.beerNameLabel.attributedText = nil
            cell.beerTaglineLabel.attributedText = nil
            cell.beerTaglineLabel.text = beer.tagline
            cell.beerNameLabel.text = beer.name
        }
        
        if let url = URL(string: beer.image_url) {
            cell.imageView?.kf.setImage(with: url)
        } else {
            cell.imageView?.image = UIImage(named: "placeholder")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !isFiltering() {
            if indexPath.row == beers.count - 10 && !loading {
                currentPage += 1
                loading = true
                presenter?.loadNextPage(page: currentPage)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Hide
        let action = UITableViewRowAction(style: .default, title: "Add to favorites") { (action, index) in
            print("add favorite")
        }
        
        action.backgroundColor = .mainBlue
        
//        // Delete
//        let deleteNotification = UITableViewRowAction(style: .default, title: "Excluir notificação") { (action, index) in
//            print("Excluir notificação")
//        }
//
//        deleteNotification.backgroundColor = .red
        
        return [action]
    }
    
    
    
    
    
    
    
    
    //MARK: - Search content
    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchBarActive && !searchBarIsEmpty()
    }
    
    func highlightSearchResult(searchString: String, resultString: String) -> NSMutableAttributedString {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: resultString)
        
        if searchString.count > 0 {
            let pattern = searchString.lowercased()
            let range: NSRange = NSMakeRange(0, resultString.count)
            
            let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options())
            
            regex.enumerateMatches(in: resultString.lowercased(), options: NSRegularExpression.MatchingOptions(), range: range) { (textCheckingResult, matchingFlags, stop) -> Void in
                let subRange = textCheckingResult?.range
                attributedString.addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor.yellow, range: subRange!)
            }
        }
        
        return attributedString
    }
}


//MARK: BeerListPresenterToViewProtocol
extension BeerListTableViewController: BeerListPresenterToViewProtocol {
    
    func showBeers(beers: [BeerModel]) {
        
        DispatchQueue.main.async {
            self.tableView.backgroundView = nil
            
            if self.isFiltering() {
                if beers.count == 0 {
                    self.tableView.backgroundView = EmptySearchView.instanceFromNib()
                }
                
                self.filteredBeers = beers
            } else {
                self.beers += beers
                self.loading = false
            }
            
            self.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)        
    }
    
}


//MARK: UISearchBarDelegate
extension BeerListTableViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarActive = false
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.didTriggerSearchEvent(searchText, beers)        
    }
    
}
