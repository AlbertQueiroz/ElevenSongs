//
//  Music.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
//

import Foundation
import SwiftData

@Model
final class Music {
    var name: String

    init(name: String) {
        self.name = name
    }
}
