//
//  ContentView.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
//

import SwiftUI
import SwiftData

struct TabBarView: View {
    @ObservedObject private var globalPlayer = GlobalPlayer.instance

    var body: some View {
        ZStack {
            TabView {
                LibraryView()
                    .tabItem {
                        Label("Library", systemImage: "play.square.stack")
                    }
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
            }
            if let music = globalPlayer.playingMusic {
                GlobalPlayerView(
                    viewModel: .init(
                        music: music
                    )
                )
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TabBarView()
        .modelContainer(for: Music.self, inMemory: true)
}
