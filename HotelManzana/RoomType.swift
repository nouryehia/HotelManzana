/* RoomType.swift
   HotelManzana
   App that would allow a hotel manager to keep track of registrations.
   Created by Nour Yehia on 8/22/18.
   Copyright © 2018 Nour Yehia. All rights reserved. */

import Foundation

struct RoomType: Equatable {
    // Declare variables that make up a room type.
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    // All available room types.
    static var all: [RoomType] {
        return [RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
                RoomType(id: 1, name: "One King", shortName: "K", price: 209),
                RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309)]
    }
}
