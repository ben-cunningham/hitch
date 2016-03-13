//
//  NewRideViewController.swift
//  hitch
//
//  Created by Benjamin Cunningham on 2016-03-12.
//  Copyright © 2016 Benjamin Cunningham. All rights reserved.
//

import UIKit

class NewRideViewController: UIViewController, RideLocalSearchViewControllerDelegate {
    var departureField: UITextField
    var destinationField: UITextField
    var datePicker: UITextField
    
    var destinationPlaceId: String = ""
    var departurePlaceId: String = ""
    
    init() {
        self.departureField = UITextField()
        self.destinationField = UITextField()
        self.datePicker = UITextField()
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.title = "Post a ride"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "add")
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor.init(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 1)
        
        self.departureField.backgroundColor = UIColor.whiteColor()
        self.departureField.frame = CGRectMake(0, 100, self.view.bounds.maxY, 50)
        self.departureField.placeholder = "Departure Location"
        self.departureField.addTarget(self, action: Selector("searchLocal:"), forControlEvents: .TouchDown)
        self.view.addSubview(self.departureField)

        self.destinationField.backgroundColor = UIColor.whiteColor()
        self.destinationField.frame = CGRectMake(0, 150, self.view.bounds.maxY, 50)
        self.destinationField.placeholder = "Destination"
        self.destinationField.addTarget(self, action: Selector("searchLocal:"), forControlEvents: .TouchDown)
        self.view.addSubview(self.destinationField)

        self.datePicker.backgroundColor = UIColor.whiteColor()
        self.datePicker.frame = CGRectMake(0, 200, self.view.bounds.maxY, 50)
        self.datePicker.placeholder = "Date"
        self.view.addSubview(self.datePicker)
        
        super.viewDidLoad()
    }
    
    func searchLocal(sender: UITextField) {
        let controller = RideLocalSearchViewController()
        controller.delegate = self
        controller.textField = sender
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func add() {
        
    }
    
    func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: RideLocalSearchControllerDelegate
    
    func isDismissingWithResult(controller: RideLocalSearchViewController, result: PointOfInterest) {
        if let textField = controller.textField {
            textField.text = result.name
            self.destinationPlaceId = result.place_id
            self.departurePlaceId = result.place_id
        }
    }
}
