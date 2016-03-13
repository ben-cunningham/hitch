//
//  RideDetailViewController.swift
//  hitch
//
//  Created by Benjamin Cunningham on 2016-03-13.
//  Copyright © 2016 Benjamin Cunningham. All rights reserved.
//

import UIKit

class RideDetailViewController: UIViewController {
    var destinationLabel: UILabel
    var departureLabel: UILabel
    var image: UIImageView
    var date: String
    var time: String
    var creator: Person
    
    lazy var reserveButton: UIButton = {
        var button = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(0,self.view.bounds.maxY-80, self.view.bounds.maxX, 80)
        button.backgroundColor = UIColor(red: 1.0, green: 175/255.0, blue: 64/255.0, alpha: 1)
        button.addTarget(self, action: Selector("reserve"), forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont.systemFontOfSize(30)
        button.setTitle("Reserve", forState: .Normal)
        return button
    }()
    
    var ride: Ride
    
    init(ride: Ride) {
        self.destinationLabel = UILabel()
        self.departureLabel = UILabel()
        self.image = UIImageView()
        self.date = ""
        self.time = ""
        self.ride = ride
        self.creator = Person(withDictionary: ["name":"bne"])
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPerson()
        
        UINavigationBar.appearance().tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.blackColor()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.destinationLabel.frame = CGRectMake(50, 70, self.view.bounds.maxX-50, 30)
        self.destinationLabel.text = ride.destinationLocation.name
        self.destinationLabel.sizeToFit()
        self.view.addSubview(self.destinationLabel)
        
        self.departureLabel.frame = CGRectMake(50, 105, self.view.bounds.maxX-50, 30)
        self.departureLabel.text = ride.departureLocation.name
        self.departureLabel.sizeToFit()
        self.view.addSubview(self.departureLabel)
        
        self.view.addSubview(self.reserveButton)
        
        self.image.frame = CGRectMake(30, 80, 70, 50)
        self.view.addSubview(self.image)
    }
    
    func reserve() {
        let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to reserve this taxi?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action) -> Void in
            
        }
        alert.addAction(cancelAction)
        let continueAction = UIAlertAction(title: "I'm Sure", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.reserveRide()
        }
        alert.addAction(continueAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func getPerson() {
//        var urlPath = "http://127.0.0.1:8000/persons"
        let imageURL = NSURL(string: "http://factmag-images.s3.amazonaws.com/wp-content/uploads/2016/01/rtr_kanye_west_jc_150407_16x9_992.jpg")
        let data = NSData(contentsOfURL: imageURL!)
        let image = UIImage(data: data!)
        
        self.image = UIImageView(image: image)

//        let url = NSURL(string: urlPath)!
//        let request = NSMutableURLRequest(URL: url)
//        
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
//            let json: AnyObject
//            do {
//                json =  try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//                
//                
//            } catch {
//                // Could not parse the JSON
//            }
//        }
//        
//        task.resume()
    }
    
    func reserveRide() {
        var urlPath = "http://127.0.0.1:8000/rides?place_id="
        //        urlPath += "ChIJ2bWxc"
        let url = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let json: AnyObject
            do {
                json =  try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let results = json["results"] as! [AnyObject]
                
            } catch {
                // Could not parse the JSON
            }
        }
        
        task.resume()

        self.navigationController?.popViewControllerAnimated(true)
    }
}
