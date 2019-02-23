//
//  PostRideViewController.swift
//  ShareRide
//
//  Created by Le, Dung Tien on 4/19/17.
//  Copyright © 2017 Dung Le. All rights reserved.
//  THIS IS A VIEW with a bunch of text fields that users need to fill out WHEN POSTING A RIDE

import UIKit
import FirebaseDatabase
import FirebaseAuth


class PostRideViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var departureTextField: UITextField!
    @IBOutlet weak var arrivalTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var seatsAvailTextField: UITextField!
    
    @IBOutlet weak var postButton: UIButton!
    
    // MARK: Properties
    let ref = FIRDatabase.database().reference(withPath: "list-of-rides")
    let usersRef = FIRDatabase.database().reference(withPath: "users")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        departureTextField.delegate = self
        arrivalTextField.delegate = self
        dateTextField.delegate = self
        timeTextField.delegate = self
        seatsAvailTextField.delegate = self
        departureTextField.tag = 0
        
        postButton.backgroundColor = .clear
        postButton.layer.cornerRadius = 5
        postButton.layer.borderWidth = 1
        postButton.layer.borderColor = UIColor.black.cgColor

        // Do any additional setup after loading the view.
    }
    
    // Helper functions for textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = departureTextField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postRideAction(_ sender: Any) {
        
        // this is to check the format of the input date
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM/dd"
        if let _ = dateFormatterGet.date(from: dateTextField.text!) {
        } else {
            let dateFormatAlertController = UIAlertController(title: "Error", message: "Please enter the date in the format mm/dd", preferredStyle: .alert)
            
            let dateFormatDefaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            dateFormatAlertController.addAction(dateFormatDefaultAction)
            
            present(dateFormatAlertController, animated: true, completion: nil)
        }
        
        // this is to check the format of the input date
        let timeFormatterGet = DateFormatter()
        timeFormatterGet.dateFormat = "HH:mm a"
        if let _ = timeFormatterGet.date(from: timeTextField.text!) {
        } else {
            let timeFormatAlertController = UIAlertController(title: "Error", message: "Please enter the time in the format HH:mm am/pm", preferredStyle: .alert)
            
            let timeFormatDefaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            timeFormatAlertController.addAction(timeFormatDefaultAction)
            
            present(timeFormatAlertController, animated: true, completion: nil)
        }
        
        // checking if all fields are filled
        if (departureTextField.text == "" || arrivalTextField.text == "" || dateTextField.text == "" || timeTextField.text == "" || seatsAvailTextField.text == "") {
            let alertController = UIAlertController(title: "Error", message: "Please fill out every field", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        
        } else {
            let currentUserID = FIRAuth.auth()?.currentUser?.uid
            let currentUserEmail = FIRAuth.auth()?.currentUser?.email
            self.usersRef.child(currentUserID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let firstName = (snapshot.value as! NSDictionary)["firstName"] as! String
                let lastName = (snapshot.value as! NSDictionary)["lastName"] as! String
                
                let rideInformationItem = RideInformationItem(departure: self.departureTextField.text!, arrival: self.arrivalTextField.text!, date: self.dateTextField.text!, time: self.timeTextField.text!, seatsAvailable: Int(self.seatsAvailTextField.text!)!, driverName: firstName + " " + lastName, driverEmail: currentUserEmail!, isRequested: 0, isAccepted: 0, isDenied: 0)
                print("hereeeeeeeeeee \(rideInformationItem)")
                let rideInformationItemRef = self.ref.child(self.departureTextField.text! + " to " + self.arrivalTextField.text!)
                rideInformationItemRef.setValue(rideInformationItem.toAnyObject())
                
            })
        }
        // An alert saying that ride is now posted
        let alertController = UIAlertController(title: "Ride Posted", message: "You have successully posted a ride! \n Thank you", preferredStyle: .alert)
        
        let postAnotherRideAction = UIAlertAction(title: "Post Another Ride", style: .default, handler: {action in self.performSegue(withIdentifier: "postAnotherRideSegue", sender: self)})
        let goToActivityAction = UIAlertAction(title: "Go to Rides", style: .default, handler: {action in self.performSegue(withIdentifier: "goToActivitySegue", sender: self)})
        
        alertController.addAction(postAnotherRideAction)
        alertController.addAction(goToActivityAction)
        
        self.present(alertController, animated: true, completion: nil)

    }
    

    @IBAction func postRideBackAction(_ sender: Any) {
        performSegue(withIdentifier: "postRideBackSegue", sender: nil)
    }

}
