//
//  RideDataViewController.swift
//  Thumbs-Up
//
//  Created by Matthew on 2/23/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RideDataViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hi there!!!!!!!!!!!")
        var reference : DatabaseReference!
        reference = Database.database().reference()
        _ = reference.child("Drivers").child("Driver01").observeSingleEvent(of: .value) { (snapshot) in
            let value  = snapshot.value as? [String : AnyObject] ?? [:]
            print("Here.......")
            print(value)
            
            for data in value{
                let textViewKey = UITextView(frame: CGRect(x: 20.0, y: 25.0, width: 250.0, height: 100.0))
                let textViewValue = UITextView(frame: CGRect(x: 20.0, y: 35.0, width: 250.0, height: 100.0))
                textViewKey.center = self.view.center
                textViewValue.center = self.view.center
                textViewKey.text = data.key
                textViewValue.text = data.value.string
//                print(textViewValue)
                
                self.view.addSubview(textViewKey)
//                self.view.addSubview(textViewValue)
            }
            }

        };

        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
