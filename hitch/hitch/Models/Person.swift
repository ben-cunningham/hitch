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
    
    init(withDictionary dictionary: NSDictionary) {
        self.firstName = dictionary["user"]!["first_name"] != nil ? dictionary["user"]!["first_name"] as! String : ""
        self.lastName = dictionary["user"]!["last_name"] != nil ? dictionary["user"]!["last_name"] as! String : ""
        self.username = dictionary["user"]!["username"] != nil ? dictionary["user"]!["username"] as! String : ""
        self.email = dictionary["user"]!["email"] != nil ? dictionary["user"]!["email"] as! String : ""
        self.pictureURL = dictionary["profile_pic"] != nil ? NSURL(string: dictionary["profile_pic"] as! String)! : NSURL(string: "")!
        
        super.init()
    }
    
    override init() {
        self.firstName = ""
        self.lastName = ""
        self.username = ""
        self.email = ""
        self.pictureURL = NSURL(string: "")!
        super.init()
    }
}
