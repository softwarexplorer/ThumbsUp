//
//  RideInformationItem.swift
//  Alex Eschenauer
//  Winter WonderHack 2019
//  TODO: FIX ME!!!!

import Foundation
import FirebaseDatabase

struct RideInformationItem {
    
    let ref: FIRDatabaseReference?
    let key: String
    
    let Departure: String
    let ComingFrom: String
    let DriverPhone: String
    let DepartureTime: String
    let NumSeatsAvailable: Int
    let NumSeatsTotal: Int
    let Price: Double
    let DriverName: String
    let DriveEmail: String
    let Comment: String
    let DriverCapacity: String
    let DriverCar: String
    let GoingTo: String
    
    init(Departure: String, ComingFrom: String, DriverPhone: String, DepartureTime: String, NumSeatsAvailable: Int, NumSeatsTotal: Int, Price: Double,
         key: String = "", DriverName: String, DriveEmail: String, Comment: String, DriverCapacity: String, DriverCar: String, GoingTo: String) {
        self.key = key
        self.DriverName = DriverName
        self.ComingFrom = ComingFrom
        self.DriveEmail = DriveEmail
        self.Departure = Departure
        self.DriverPhone = DriverPhone
        self.DepartureTime = DepartureTime
        self.NumSeatsAvailable = NumSeatsAvailable
        self.NumSeatsTotal = NumSeatsTotal
        self.Price = Price
        self.Comment = Comment
        self.DriverCapacity = DriverCapacity
        self.DriverCar = DriverCar
        self.GoingTo = GoingTo
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        DriverName = snapshotValue["DriverName"] as! String
        DriveEmail = snapshotValue["DriveEmail"] as! String
        Departure = snapshotValue["Departure"] as! String
        ComingFrom = snapshotValue["ComingFrom"] as! String
        DriverPhone = snapshotValue["DriverPhone"] as! String
        NumSeatsAvailable = snapshotValue["NumSeatsAvailable"] as! Int
        NumSeatsTotal = snapshotValue["NumSeatsTotal"] as! Int
        Price = snapshotValue["Price"] as! Double
        Departure = snapshotValue["Departure"] as! String
        Comment = snapshotValue["Comment"] as! String
        DriverCapacity = snapshotValue["DriverCapacity"] as! String
        DriverCar = snapshotValue["DriverCar"] as! String
        GoingTo = snapshotValue["GoingTo"] as! String
        DepartureTime = snapshotValue["DriverCar"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "key": key,
            "DriverName": DriverName,
            "ComingFrom": ComingFrom,
            "DriveEmail": DriveEmail,
            "Departure": Departure,
            "DriverPhone": DriverPhone,
            "DepartureTime": DepartureTime,
            "NumSeatsAvailable": NumSeatsAvailable,
            "NumSeatsTotal": NumSeatsTotal,
            "Price": Price,
            "Comment": Comment,
            "DriverCapacity": DriverCapacity,
            "DriverCar": DriverCar,
            "GoingTo": GoingTo
        ]
    }
}
