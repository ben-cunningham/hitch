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

struct PointOfInterest {
    var name: String
    var street: String
    var city: String
    var place_id: String
}

class LocalSearchResults: UITableViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager
    var results: [PointOfInterest] = []
    var userLocation: Location
    
    weak var delegate: LocalSearchResultsDelegate?
    
    var isLoading: Bool = false
    
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
        
        return self.results.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let text = self.results[indexPath.row].name
        cell.textLabel?.text = text
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let delegate = self.delegate {
            delegate.isDismissingWithResult(self, result: self.results[indexPath.row])
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        self.userLocation.latitude = newLocation.coordinate.latitude
        self.userLocation.longitute = newLocation.coordinate.longitude
    }
    
    func pointOfInterestForPlace(place: NSDictionary) -> PointOfInterest {
        let name = place["description"] as! String
        let place_id = place["place_id"] as! String
        let terms = place["terms"] as! NSArray
        let streetTerm = terms[1] as! NSDictionary
        let cityTerm = terms[2] as! NSDictionary
        let street = streetTerm["value"] as! String
        let city = cityTerm["value"] as! String
        let poi = PointOfInterest(name: name, street: street, city: city, place_id: place_id)
        return poi
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
        
        print(urlPath)
        
        let url = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        self.isLoading = true
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            self.results.removeAll()
            let json: AnyObject
            do {
                json =  try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let predictions = json["predictions"] as! NSArray
                for place in predictions {
                    self.results.append(self.pointOfInterestForPlace(place as! NSDictionary))
                }
            } catch {
                // Could not parse the JSON
            }
            self.isLoading = false
            self.tableView.performSelectorOnMainThread(Selector("reloadData"), withObject: nil, waitUntilDone: true)
        }
        
        task.resume()
    }
}

protocol LocalSearchResultsDelegate: class {
    func isDismissingWithResult(searchResultsController: LocalSearchResults,result: PointOfInterest)
}
