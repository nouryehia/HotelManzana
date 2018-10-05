/* Registration.swift
   HotelManzana
   App that would allow a hotel manager to keep track of registrations.
   Created by Nour Yehia on 8/22/18.
   Copyright © 2018 Nour Yehia. All rights reserved. */

import Foundation

struct Registration {
    // Declare variables that make up a registration.
    var firstName: String
    var lastName: String
    var email: String
    
    var checkIn: Date
    var checkOut: Date
    
    var adultsNum: Int
    var childrenNum: Int
    
    var wifi: Bool
    
    var roomType: RoomType
}
