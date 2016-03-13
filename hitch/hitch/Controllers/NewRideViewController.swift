//
//  NewRideViewController.swift
//  hitch
//
//  Created by Benjamin Cunningham on 2016-03-12.
//  Copyright © 2016 Benjamin Cunningham. All rights reserved.
//

import UIKit

class NewRideViewController: UIViewController {
    var departureField: UITextField
    var destinationField: UITextField
    var datePicker: UITextField
    
    init() {
        self.departureField = UITextField(frame: CGRectMake(0, 0, 150, 50))
        self.destinationField = UITextField(frame: CGRectMake(0, 0, 150, 50))
        self.datePicker = UITextField(frame: CGRectMake(0, 0, 150, 50))
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "add")
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(self.departureField)
        self.view.addSubview(self.destinationField)
        self.view.addSubview(self.datePicker)
        
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
