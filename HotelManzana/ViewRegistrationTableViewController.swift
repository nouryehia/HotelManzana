/* ViewRegistrationTableViewController.swift
   HotelManzana
   App that would allow a hotel manager to keep track of registrations.
   Created by Nour Yehia on 8/23/18.
   Copyright © 2018 Nour Yehia. All rights reserved. */

import UIKit

class ViewRegistrationTableViewController: UITableViewController {
    
    // Holds registration object that is being used.
    var registration: Registration?
    
    // Called once the view controller has loaded its view hierarchy into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calculate lenngth of stay.
        let stayLength = Int(Calendar.current.startOfDay(for: registration!.checkOut).timeIntervalSince(Calendar.current.startOfDay(for: registration!.checkIn))/86400)
        // Formats date.
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        
        // Update info.
        firstNameCell.detailTextLabel?.text = registration!.firstName
        lastNameCell.detailTextLabel?.text = registration!.lastName
        emailCell.detailTextLabel?.text = registration!.email
        checkInCell.detailTextLabel?.text = dateFormatter.string(from: (registration!.checkIn))
        checkOutCell.detailTextLabel?.text = dateFormatter.string(from: (registration!.checkOut))
        adultsNumCell.detailTextLabel?.text = String(registration!.adultsNum)
        childrenNumCell.detailTextLabel?.text = String(registration!.childrenNum)
        if registration!.wifi {
            wifiCell.detailTextLabel?.text = "Yes"
            wifi.text = "Yes"
            wifiPrice.text = "$ \(10 * stayLength)"
            totalPrice.text = "$ \((registration!.roomType.price + 10) * stayLength)"
        }
        else {
            wifiCell.detailTextLabel?.text = "No"
            wifi.text = "No"
            wifiPrice.text = "$ 0"
            totalPrice.text = "$ \((registration!.roomType.price) * stayLength)"
        }
        roomTypeCell.detailTextLabel?.text = registration!.roomType.name
        
        // Update price.
        nights.text = String(stayLength)
        nightsPrice.text = "$ \(registration!.roomType.price * stayLength)"
    }
    
    // Declare outlets.
    @IBOutlet weak var firstNameCell: UITableViewCell!
    @IBOutlet weak var lastNameCell: UITableViewCell!
    @IBOutlet weak var emailCell: UITableViewCell!
    @IBOutlet weak var checkInCell: UITableViewCell!
    @IBOutlet weak var checkOutCell: UITableViewCell!
    @IBOutlet weak var adultsNumCell: UITableViewCell!
    @IBOutlet weak var childrenNumCell: UITableViewCell!
    @IBOutlet weak var wifiCell: UITableViewCell!
    @IBOutlet weak var roomTypeCell: UITableViewCell!
    @IBOutlet weak var nights: UILabel!
    @IBOutlet weak var nightsPrice: UILabel!
    @IBOutlet weak var wifi: UILabel!
    @IBOutlet weak var wifiPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!

    // Prepares for segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editRegistration" {
            let navigationViewController = segue.destination as? UINavigationController
            let tableViewController = navigationViewController?.viewControllers.first as! AddRegistrationTableViewController
            tableViewController.navigationItem.title = "Edit Registration"
            tableViewController.registrationToEdit = registration
        }
    }
}
