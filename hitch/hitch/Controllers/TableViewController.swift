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
    
    var rides = [Ride]()
    
    init() {
        self.localSearchResults = LocalSearchResults(nibName: nil, bundle: nil)
        self.searchController = UISearchController(searchResultsController: self.localSearchResults)
        super.init(style: .Plain)
    }
    
    override func viewDidLoad() {
        let button = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("newRide"))
        button.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = button
        
        self.localSearchResults.delegate = self
        
        // search bar
        self.searchController.searchResultsUpdater = self.localSearchResults
        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.navigationItem.titleView = self.searchController.searchBar
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchResultsController?.view.hidden = false
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 237.0/255, green: 247.0/255, blue: 119.0/255, alpha: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: TableViewController delegate methods
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ride = self.rides[indexPath.row] as! Ride
        let cell = LocationTableViewCell(departureDestination: ride.departureLocation.name, date: ride.date)
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rides.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let ride = self.rides[indexPath.row]
        let controller = RideDetailViewController(ride: ride)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func newRide() {
        let viewController = NewRideViewController()
        let navController = NavigationController(rootViewController: viewController)
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    func rideForDictionary(result: NSDictionary) {
        let desinationDic = result["destination"] as! Dictionary<String, String>
        let departureDic = result["departure"] as! Dictionary<String, String>
        let destination = PointOfInterest(name: desinationDic["name"]!, street: "", city: "", place_id: "")
        let departure = PointOfInterest(name: departureDic["name"]!, street: "", city: "", place_id: "")
        let date = result["date"] as! String
        let time = result["time"] as! String
        let ride = Ride(destination: destination, departure: departure, date: date, time: time)
        self.rides.append(ride)
    }
    
    func requestForRidesWithPointOfInterest(poi: PointOfInterest) {
        let text = searchController.searchBar.text
        if text!.characters.count == 0 {
            return
        }
        var urlPath = "http://127.0.0.1:8000/rides?place_id="
        urlPath += poi.place_id
//        urlPath += "ChIJ2bWxc"
        let url = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            self.rides.removeAll()
            let json: AnyObject
            do {
                json =  try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let results = json["results"] as! [AnyObject]
                for result in results {
                    self.rideForDictionary(result as! NSDictionary)
                }

            } catch {
                // Could not parse the JSON
            }
            self.tableView.performSelectorOnMainThread(Selector("reloadData"), withObject: nil, waitUntilDone: true)
        }
        
        task.resume()
    }
    
    // MARK: LocalSearchResultsDelegate
    
    func isDismissingWithResult(searchResultsController: LocalSearchResults, result: PointOfInterest) {
        searchResultsController.dismissViewControllerAnimated(true, completion: nil)
        self.requestForRidesWithPointOfInterest(result)
    }
}