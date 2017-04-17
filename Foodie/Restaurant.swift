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
    let phone: String!
    var rating: String!
    var isVisited: Bool!

    init(dict: Dictionary<String, AnyObject>) {
        name = dict["name"] as! String
        location = dict["location"] as! String
        type = dict["type"] as! String
        phone = dict["phone"] as! String
        isVisited = dict["isVisited"] as! Bool
        rating = ""
    }
}
