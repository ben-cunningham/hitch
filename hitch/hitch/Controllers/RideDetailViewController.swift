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
    
    var ride: Ride
    
    init(ride: Ride) {
        self.destinationLabel = UILabel()
        self.departureLabel = UILabel()
        self.image = UIImageView()
        self.date = ""
        self.time = ""
        self.ride = ride
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        UINavigationBar.appearance().tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.blackColor()
        self.view.backgroundColor = UIColor.whiteColor()
        
//        self.//
    }
}
