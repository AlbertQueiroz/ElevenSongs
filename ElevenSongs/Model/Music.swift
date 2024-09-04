//
//  Music.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
//

import Foundation
import SwiftData

@Model
public final class Music {
    var name: String
    var url: URL?

    init(name: String, url: URL?) {
        self.name = name
        self.url = url
    }
}
