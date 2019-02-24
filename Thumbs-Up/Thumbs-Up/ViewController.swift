//
//  ViewController.swift
//  Thumbs-Up
//
//  Created by Matthew on 2/22/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var findRide: UIButton!
    @IBOutlet weak var submitRide: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func findRideButton(_ sender: Any) {
        performSegue(withIdentifier: "ViewRides", sender: self)
    }
    @IBAction func submitRideButton(_ sender: Any) {
        performSegue(withIdentifier: "postRide", sender: self)
    }

}

