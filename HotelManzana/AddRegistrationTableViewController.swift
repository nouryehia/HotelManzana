/* AddRegistrationTableViewController.swift
   HotelManzana
   App that would allow a hotel manager to keep track of registrations.
   Created by Nour Yehia on 8/21/18.
   Copyright © 2018 Nour Yehia. All rights reserved. */

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    
    // used to show and hide date pickers.
    let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    var showCheckInDatePicker = false {
        didSet {
            checkInDatePicker.isHidden = !showCheckInDatePicker
        }
    }
    var showCheckOutDatePicker = false {
        didSet {
            checkOutDatePicker.isHidden = !showCheckOutDatePicker
        }
    }
    // Declare a valid registration variable.
    var roomType: RoomType?
    var registration: Registration? {
        guard let roomType = roomType else { return nil }
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkIn = checkInDatePicker.date
        let checkOut = checkOutDatePicker.date
        let adultsNum = Int(adultsStepper.value)
        let childrenNum = Int(childrenStepper.value)
        let wifi = wifiSwitch.isOn
        return Registration(firstName: firstName, lastName: lastName, email: email, checkIn: checkIn, checkOut: checkOut, adultsNum: adultsNum, childrenNum: childrenNum, wifi: wifi, roomType: roomType)
    }
    
    //Used when editing a room rather than adding.
    var registrationToEdit: Registration?
    var edit = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if let registration = registrationToEdit {
            // If editing, display appropriate info.
            firstNameTextField.text = registration.firstName
            lastNameTextField.text = registration.lastName
            emailTextField.text = registration.email
            checkInDatePicker.date = registration.checkIn
            checkOutDatePicker.date = registration.checkOut
            adultsStepper.value = Double(registration.adultsNum)
            childrenStepper.value = Double(registration.childrenNum)
            if registration.wifi {
                wifiSwitch.isOn = true
            }
            else {
                wifiSwitch.isOn = false
            }
            roomType = registration.roomType
            edit = true
        }
        else {
            // Otherwise, display nothing except today's date.
            let today = Calendar.current.startOfDay(for: Date())
            checkInDatePicker.minimumDate = today
            checkOutDatePicker.minimumDate = today
        }
        
        // Updates.
        updateDates()
        updateGuests()
        updateRoomType()
        updateDoneButton()
    }
    
    // Declare outlets.
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var adultsNumLabel: UILabel!
    @IBOutlet weak var adultsStepper: UIStepper!
    @IBOutlet weak var childrenNumLabel: UILabel!
    @IBOutlet weak var childrenStepper: UIStepper!
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // Updates dates when pickers are used.
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        updateDates()
    }
    
    // Updates guests number labels when steppers are used.
    @IBAction func guestNumChanged(_ sender: UIStepper) {
        updateGuests()
    }
    
    // Dismisses the view when cancel button is tapped.
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // Receives info from almost UI objects to determine whether there is enough info to save.
    @IBAction func checkIfDone(_ sender: Any) {
        updateDoneButton()
    }
    
    // Updates date pickers/labels.
    func updateDates() {
        // Make check out date at least one day after check in.
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        
        // Desired formatting style in cell detail.
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        // Update date labels.
        checkInLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    // Update the number of guests labels based on stepper value.
    func updateGuests() {
        adultsNumLabel.text = "\(Int(adultsStepper.value))"
        childrenNumLabel.text = "\(Int(childrenStepper.value))"
    }
    
    // Update the room type label based on room type selected.
    func updateRoomType(){
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        }
        else {
            roomTypeLabel.text = "Not Set"
        }
        updateDoneButton()
    }
    
    // Makes sure there is enough info before enabling done button.
    func updateDoneButton(){
        doneButton.isEnabled = false
        //guard let roomType = roomType else { return }
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let adultsNum = Int(adultsStepper.value)
        doneButton.isEnabled = !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && adultsNum > 0 && roomType != nil
    }
    
    // Updates room type based on selection.
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    // Formats height of cells and hide/shows date pickers as appropriate.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerIndexPath.section, checkInDatePickerIndexPath.row):
            if showCheckInDatePicker {
                return 216.0
            }
            else {
                return 0.0
            }
        case (checkOutDatePickerIndexPath.section, checkOutDatePickerIndexPath.row):
            if showCheckOutDatePicker {
                return 216.0
            }
            else {
                return 0.0
            }
        default: return 44.0
        }
    }
    
    // Determines whether date pickers should be showing or not.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row){
        case (checkInDatePickerIndexPath.section, checkInDatePickerIndexPath.row - 1):
            if showCheckInDatePicker {
                showCheckInDatePicker = false
            }
            else if showCheckOutDatePicker {
                showCheckOutDatePicker = false
                showCheckInDatePicker = true
            }
            else {
                showCheckInDatePicker = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        case (checkOutDatePickerIndexPath.section, checkOutDatePickerIndexPath.row - 1):
            if showCheckOutDatePicker {
                showCheckOutDatePicker = false
            }
            else if showCheckInDatePicker {
                showCheckInDatePicker = false
                showCheckOutDatePicker = true
            }
            else {
                showCheckOutDatePicker = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        default: break
        }
    }

    // Prepares for segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectRoomType" {
            let backButton = UIBarButtonItem()
            backButton.title = ""
            navigationItem.backBarButtonItem = backButton
            let destination = segue.destination as? SelectRoomTypeTableViewController
            destination?.delegate = self
            destination?.roomType = roomType
        }
    }
}
