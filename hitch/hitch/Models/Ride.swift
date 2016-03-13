//
//  Ride.swift
//  hitch
//
//  Created by Benjamin Cunningham on 2016-03-12.
//  Copyright © 2016 Benjamin Cunningham. All rights reserved.
//

import UIKit

class Ride: NSObject {
    var passengers: [Person]
    var destinationLocation: PointOfInterest
    var departureLocation: PointOfInterest
    var date: String
    var time: String
    var creater: Person
    
    init(destination: PointOfInterest, departure: PointOfInterest, date: String, time: String, person: NSDictionary) {
        self.passengers = [Person]()
        self.destinationLocation = destination
        self.departureLocation = departure
        self.date = date
        self.time = time
        self.creater = Person(withDictionary: person)
        
        super.init()
    }
    
    init(destination: PointOfInterest, departure: PointOfInterest, date: String, time: String) {
        self.passengers = [Person]()
        self.destinationLocation = destination
        self.departureLocation = departure
        self.date = date
        self.time = time
        self.creater = Person()
        
        super.init()
    }
}
