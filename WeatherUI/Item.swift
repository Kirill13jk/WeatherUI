//
//  Item.swift
//  WeatherUI
//
//  Created by prom1 on 15.10.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
