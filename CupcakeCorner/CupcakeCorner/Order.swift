//
//  Order.swift
//  CupcakeCorner
//
//  Created by Gabriel on 01/06/23.
//

import SwiftUI

class Order: ObservableObject {
    @Published var info: OrderInfo
    
    init(info: OrderInfo) {
        self.info = info
    }
}

struct OrderInfo: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        
        if name.isValid && streetAddress.isValid && city.isValid && zip.isValid {
            return true
        }
        
        return false
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}

fileprivate extension String {
    var isValid: Bool {
        let strimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        if strimmed.isEmpty {
            return false
        }
        
        return true
    }
}
