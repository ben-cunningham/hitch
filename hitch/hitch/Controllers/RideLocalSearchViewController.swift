//
//  RideLocalSearchViewController.swift
//  hitch
//
//  Created by Benjamin Cunningham on 2016-03-12.
//  Copyright © 2016 Benjamin Cunningham. All rights reserved.
//

import UIKit

class RideLocalSearchViewController: UITableViewController, LocalSearchResultsDelegate {
    var searchController: UISearchController
    var localSearchResults: LocalSearchResults
    weak var textField: UITextField?
    
    weak var delegate: RideLocalSearchViewControllerDelegate?
    
    init() {
        self.localSearchResults = LocalSearchResults(nibName: nil, bundle: nil)
        self.searchController = UISearchController(searchResultsController: self.localSearchResults)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        self.localSearchResults.delegate = self
        
        // search bar
        self.searchController.searchResultsUpdater = self.localSearchResults
        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchResultsController?.view.hidden = false
    }
    
    // MARK: LocalSearchResultsDelegate
    
    func isDismissingWithResult(result: PointOfInterest) {
        self.delegate?.isDismissingWithResult(self, result: result)
        self.navigationController?.popViewControllerAnimated(true)
    }
}

protocol RideLocalSearchViewControllerDelegate: class {
    func isDismissingWithResult(controller: RideLocalSearchViewController,result: PointOfInterest)
}
