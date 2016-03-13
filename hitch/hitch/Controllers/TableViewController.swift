//
//  TableViewController.swift
//  hitch
//
//  Created by Benjamin Cunningham on 2016-03-12.
//  Copyright © 2016 Benjamin Cunningham. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, LocalSearchResultsDelegate {
    var searchController: UISearchController
    var localSearchResults: LocalSearchResults
    
    var rides = [String]()
    
    init() {
        self.rides = ["ben", "austin", "jonny"]
        self.localSearchResults = LocalSearchResults(nibName: nil, bundle: nil)
        self.searchController = UISearchController(searchResultsController: self.localSearchResults)
        super.init(style: .Plain)
    }
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("newRide"))
        
        self.localSearchResults.delegate = self
        
        // search bar
        self.searchController.searchResultsUpdater = self.localSearchResults
        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.navigationItem.titleView = self.searchController.searchBar
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchResultsController?.view.hidden = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: TableViewController delegate methods
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        cell.textLabel?.text = self.rides[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rides.count
    }
    
    func newRide() {
        let viewController = NewRideViewController()
        let navController = NavigationController(rootViewController: viewController)
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    func requestForRidesWithPointOfInterest(poi: PointOfInterest) {
        let text = searchController.searchBar.text
        if text!.characters.count == 0 {
            return
        }
        let urlPath = ""
        let url = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let json: AnyObject
            do {
                json =  try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
            } catch {
                // Could not parse the JSON
            }
            self.tableView.performSelectorOnMainThread(Selector("reloadData"), withObject: nil, waitUntilDone: true)
        }
        
        task.resume()
    }
    
    // MARK: LocalSearchResultsDelegate
    
    func isDismissingWithResult(result: PointOfInterest) {
        self.requestForRidesWithPointOfInterest(result)
    }
}