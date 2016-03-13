//
//  NewRideViewController.swift
//  hitch
//
//  Created by Benjamin Cunningham on 2016-03-12.
//  Copyright © 2016 Benjamin Cunningham. All rights reserved.
//

import UIKit

class NewRideViewController: UIViewController {
    
    let textfield = UITextField(frame: CGRectMake(100,100,200,20))
    let timefield = UITextField(frame: CGRectMake(100,160,100,20))
    let destination = UITextField(frame: CGRectMake(100,130,100,20))
    
    var toolBar = UIToolbar()


    
    //done button shenanigans 
    func doneButton(sender: UIButton){
        textfield.resignFirstResponder()
        
    }
    
    func timeFieldEdit(sender: UITextField){
        let datePickerView : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("timePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    
    func textFieldEdit(sender: UITextField){
        let datePickerView : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerChanged(sender: UIDatePicker){
       
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        textfield.text = dateFormatter.stringFromDate(sender.date)
        
        
    }
    
    func timePickerChanged(sender: UIDatePicker){
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        //timefield.text = dateFormatter.stringFromDate(sender.)
        
        
    }
    
    func donePicker(sender: UIButton) {
        
       // close the date picker when clicked
        
    }
    
    
    
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
        
        textfield.addTarget(self, action: "textFieldEdit:", forControlEvents: .EditingDidBegin)
        timefield.addTarget(self, action: "timeFieldEdit:", forControlEvents: .EditingDidBegin)
        timefield.backgroundColor = UIColor.greenColor()
        textfield.backgroundColor = UIColor.greenColor()
        textfield.placeholder = "choose your date"
        destination.backgroundColor = UIColor.blueColor()
        timefield.placeholder = "Choose time"
        
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Bordered, target: self, action: "donePicker")
        var spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        
        textfield.inputAccessoryView = toolBar
        
        
        self.view.addSubview(textfield)
        self.view.addSubview(destination)
        self.view.addSubview(timefield)
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
