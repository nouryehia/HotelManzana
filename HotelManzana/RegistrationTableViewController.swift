/* RegistrationTableViewController.swift
   HotelManzana
   App that would allow a hotel manager to keep track of registrations.
   Created by Nour Yehia on 8/23/18.
   Copyright © 2018 Nour Yehia. All rights reserved. */

import UIKit

class RegistrationTableViewController: UITableViewController {
    // Array to hold all registrations.
    var registrations: [Registration] = []
    
    // Array to hold registrations sorted by check in date.
    var sortedRegistrations: [Registration] = []
    
    // Int that will tell view registration view controller which registration to take from array.
    var viewIndex: Int?

    // Determines the number of rows in sections based on number of registrations.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }

    // Formats cells based on registration info.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "registrationCell", for: indexPath)
        let registration = sortedRegistrations[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        cell.textLabel?.text = "\(registration.firstName) \(registration.lastName)"
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: registration.checkIn)) - \(dateFormatter.string(from: registration.checkOut)) : \(registration.roomType.name)"
        return cell
    }
    
    // Prepares for segue. Sends info to view registration view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewRegistrationTableViewController = segue.destination as? ViewRegistrationTableViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow, segue.identifier == "viewRegistration" {
            let backButton = UIBarButtonItem()
            backButton.title = ""
            navigationItem.backBarButtonItem = backButton
            viewIndex = indexPath.row
            let registration = sortedRegistrations[viewIndex!]
            viewRegistrationTableViewController.registration = registration
        }
    }
    
    // Edit or adds registration if coming from add registration table view controller
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController, let registration = addRegistrationTableViewController.registration else { return }
        if addRegistrationTableViewController.edit {
            registrations[viewIndex!] = registration
        }
        else {
            registrations.append(registration)
        }
        // Sorts registrations based on check in/out dates.
        sortedRegistrations = registrations.sorted { $0.checkIn < $1.checkOut}
        tableView.reloadData()
    }
}
