/* SelectRoomTypeTableViewController.swift
   HotelManzana
   App that would allow a hotel manager to keep track of registrations.
   Created by Nour Yehia on 8/22/18.
   Copyright © 2018 Nour Yehia. All rights reserved. */

import UIKit

// Create delegate protocol.
protocol SelectRoomTypeTableViewControllerDelegate {
    func didSelect(roomType: RoomType)
}

class SelectRoomTypeTableViewController: UITableViewController {
    
    // Declare variables.
    var delegate: SelectRoomTypeTableViewControllerDelegate?
    var roomType: RoomType?

    // Determines number of rows based on possible choices.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.all.count
    }

    // Updates cell information based on room type.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomTypeCell", for: indexPath)
        let roomType = RoomType.all[indexPath.row]
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "$ \(roomType.price)"
        // Add a checkmark if room type is selected.
        if roomType == self.roomType {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    // Sets new room type when cell is selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        roomType = RoomType.all[indexPath.row]
        delegate?.didSelect(roomType: roomType!)
        tableView.reloadData()
    }
}
