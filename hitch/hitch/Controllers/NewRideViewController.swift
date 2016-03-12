//
//  NewRideViewController.swift
//  hitch
//
//  Created by Benjamin Cunningham on 2016-03-12.
//  Copyright © 2016 Benjamin Cunningham. All rights reserved.
//

import UIKit

class NewRideViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "add")
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor.whiteColor()
        super.viewDidLoad()
    }
    
    func add() {
        
    }
    
    func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//    }
}
