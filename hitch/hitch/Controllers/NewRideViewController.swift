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
    var timePicker: UITextField
    
    var destination: PointOfInterest
    var departure: PointOfInterest
    
    var dateString: String = ""
    var timeString: String = ""
    
    init() {
        self.departureField = UITextField()
        self.destinationField = UITextField()
        self.datePicker = UITextField()
        self.timePicker = UITextField()
        
        self.destination = PointOfInterest(name: "", street: "", city: "", place_id: "")
        self.departure = PointOfInterest(name: "", street: "", city: "", place_id: "")

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.title = "Post a ride"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 237.0/255, green: 247.0/255, blue: 119.0/255, alpha: 1)
        
        let leftButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
        leftButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = leftButton
        let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "add")
        rightButton.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = rightButton
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor.init(red: 230.0/255, green: 230.0/255, blue: 230.0/255, alpha: 1)
        
        self.departureField.backgroundColor = UIColor.whiteColor()
        self.departureField.frame = CGRectMake(0, 100, self.view.bounds.maxY, 50)
        self.departureField.placeholder = "Departure Location"
        self.departureField.addTarget(self, action: Selector("searchLocal:"), forControlEvents: .TouchDown)
        self.departureField.leftViewMode = UITextFieldViewMode.Always
        self.departureField.leftView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        self.view.addSubview(self.departureField)

        self.destinationField.backgroundColor = UIColor.whiteColor()
        self.destinationField.frame = CGRectMake(0, 150, self.view.bounds.maxY, 50)
        self.destinationField.placeholder = "Destination"
        self.destinationField.addTarget(self, action: Selector("searchLocal:"), forControlEvents: .TouchDown)
        self.destinationField.leftViewMode = UITextFieldViewMode.Always
        self.destinationField.leftView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        self.view.addSubview(self.destinationField)

        self.datePicker.backgroundColor = UIColor.whiteColor()
        self.datePicker.frame = CGRectMake(0, 200, self.view.bounds.maxY, 50)
        self.datePicker.placeholder = "Date"
        self.datePicker.addTarget(self, action: Selector("showDatePicker:"), forControlEvents: .TouchDown)
        self.datePicker.leftViewMode = UITextFieldViewMode.Always
        self.datePicker.leftView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        self.view.addSubview(self.datePicker)
        
        self.timePicker.backgroundColor = UIColor.whiteColor()
        self.timePicker.frame = CGRectMake(0, 250, self.view.bounds.maxY, 50)
        self.timePicker.placeholder = "Departure Time"
        self.timePicker.addTarget(self, action: Selector("showTimePicker:"), forControlEvents: .TouchDown)
        self.timePicker.leftViewMode = UITextFieldViewMode.Always
        self.timePicker.leftView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        self.view.addSubview(self.timePicker)
        
        super.viewDidLoad()
    }
    
    func searchLocal(sender: UITextField) {
        let controller = RideLocalSearchViewController()
        controller.delegate = self
        controller.textField = sender
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showDatePicker(sender: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePicker
        datePicker.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func showTimePicker(sender: UITextField) {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = UIDatePickerMode.Time
        sender.inputView = timePicker
        timePicker.addTarget(self, action: Selector("handleTimePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .MediumStyle
        self.datePicker.text = timeFormatter.stringFromDate(sender.date)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.dateString = dateFormatter.stringFromDate(sender.date)
    }
    
    func handleTimePicker(sender: UIDatePicker) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.timeStyle = .MediumStyle
        self.timePicker.text = timeFormatter.stringFromDate(sender.date)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        self.timeString = dateFormatter.stringFromDate(sender.date)
    }
    
    func add() {
        let urlPath = "http://127.0.0.1:8000/rides"
        let url = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postDic = self.getPOSTData()
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(postDic, options: [])
            request.HTTPBody = data
        } catch {
            fatalError("")
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let json: AnyObject
            do {
                json =  try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            } catch {
                // Could not parse the JSON
            }
        }
        
        task.resume()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getPOSTData() -> Dictionary<String, AnyObject> {
        var params = Dictionary<String, AnyObject>()
        params["passengers"] = [1]
        params["departure"] = [
            "place_id" : self.departure.place_id,
            "name" : self.departure.name
        ]
        params["destination"] = [
            "place_id" : self.destination.place_id,
            "name" : self.destination.name
        ]
        params["time"] = self.timeString
        params["date"] = self.dateString
        return params
    }
    
    func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: RideLocalSearchControllerDelegate
    
    func isDismissingWithResult(controller: RideLocalSearchViewController, result: PointOfInterest) {
        if let textField = controller.textField {
            textField.text = result.name
            print(result)
            if (textField.placeholder?.rangeOfString("Departure") != nil) {
                self.departure.place_id = result.place_id
                self.departure.name = result.name
            }
            else {
                self.destination.place_id = result.place_id
                self.destination.name = result.name
            }
        }
    }
}
