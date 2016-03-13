//
//  Person.swift
//  hitch
//
//  Created by Benjamin Cunningham on 2016-03-13.
//  Copyright © 2016 Benjamin Cunningham. All rights reserved.
//

import Foundation

class Person: NSObject {
    var firstName: String
    var lastName: String
    var username: String
    var email: String
    var pictureURL: NSURL
    
    init(withDictionary dictionary: Dictionary<String, AnyObject>) {
        self.firstName = dictionary["first_name"] != nil ? dictionary["first_name"] as! String : ""
        self.lastName = dictionary["last_name"] != nil ? dictionary["last_name"] as! String : ""
        self.username = dictionary["username"] != nil ? dictionary["username"] as! String : ""
        self.email = dictionary["email"] != nil ? dictionary["email"] as! String : ""
        self.pictureURL = dictionary["img"] != nil ? dictionary["img"] as! NSURL : NSURL(string: "")!
        
        super.init()
    }
}
