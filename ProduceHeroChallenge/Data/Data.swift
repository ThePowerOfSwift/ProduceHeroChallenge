//
//  Data.swift
//  ProduceHeroChallenge
//
//  Created by Li Pan on 2020-02-23.
//  Copyright © 2020 Li Pan. All rights reserved.
//

import Foundation

struct City {
    var name: String
    var businesses: [Business]
}

struct Business {
    var name: String
    var address: String
    var signed: Bool
    var orders: [Order] = makeOrders()
}

struct Order {
    var name: String
    var quantity: Int
}

fileprivate func makeOrders() -> [Order] {
    var orders: [Order] = []
    for i in 1...6 {
        orders.append(.init(name: String(i), quantity: i * 10))
    }
    
    return orders
}
