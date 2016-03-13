//
//  LocationTableViewCell.swift
//  hitch
//
//  Created by Benjamin Cunningham on 2016-03-12.
//  Copyright © 2016 Benjamin Cunningham. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    lazy var departureLabel: UILabel = {
        return UILabel()
        
    }()
    
    lazy var dateLabel: UILabel = {
        return UILabel()
    }()
    
    init(departureDestination: String, date: String) {
        super.init(style: .Default, reuseIdentifier: nil)
        self.departureLabel.text = departureDestination
        self.dateLabel.text = date
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.departureLabel.frame = CGRectMake(20, 0, self.bounds.maxX, 40)
        self.addSubview(self.departureLabel)
        
        self.dateLabel.frame = CGRectMake(20, 20, self.bounds.maxX, 50)
        self.addSubview(self.dateLabel)
    }
}
