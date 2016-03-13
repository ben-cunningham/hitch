//
//  LocalSearchResults.swift
//  hitch
//
//  Created by Benjamin Cunningham on 2016-03-12.
//  Copyright © 2016 Benjamin Cunningham. All rights reserved.
//

import UIKit
import MapKit

struct Location {
    var longitute: Double
    var latitude: Double
}

class LocalSearchResults: UITableViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager
    var results: [MKMapItem] = []
    var userLocation: Location
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.locationManager = CLLocationManager()
        self.userLocation = Location(longitute: 0.0, latitude: 0.0)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.results.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let text = self.results[indexPath.row].name
        cell.textLabel?.text = text
        return cell
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        self.userLocation.latitude = newLocation.coordinate.latitude
        self.userLocation.longitute = newLocation.coordinate.longitude
    }
}

extension LocalSearchResults: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let text = searchController.searchBar.text
        if text!.characters.count == 0 {
            return
        }
        // input
        var urlPath = "https://maps.googleapis.com/maps/api/place/autocomplete/json?types=establishment&" + "input="
        urlPath += text!
        urlPath += "&"
        urlPath += "location="
        urlPath += String(self.userLocation.latitude)
        urlPath += ","
        urlPath += String(self.userLocation.longitute)
        urlPath += "&radius=500"
        urlPath += "&key=AIzaSyBf3UDAX7z7kbkRsKm7tn2I_6LxfvL85Og"
        
        let url = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let json: AnyObject
            do {
                json =  try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                print(json)
            } catch {
                // Could not parse the JSON
            }
        }
        
        task.resume()
        self.tableView.reloadData()
    }
}
