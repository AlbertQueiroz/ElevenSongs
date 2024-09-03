//
//  Item.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
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
