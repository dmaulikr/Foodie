//
//  Restaurant.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 12/04/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import Foundation

struct Restaurant {
    let name: String!
    let location: String!
    let type: String!

    init(dict: Dictionary<String, String>) {
        name = dict["name"]
        location = dict["location"]
        type = dict["type"]
    }
}
