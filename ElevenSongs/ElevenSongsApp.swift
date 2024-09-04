//
//  ElevenSongsApp.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
//

import SwiftUI
import SwiftData

@main
struct ElevenSongsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Music.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            SignInView()
        }
        .modelContainer(sharedModelContainer)
    }
}
