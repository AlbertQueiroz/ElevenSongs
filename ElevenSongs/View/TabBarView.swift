//
//  ContentView.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
//

import SwiftUI
import SwiftData

struct TabBarView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Music]

    var body: some View {
        ZStack {
            TabView {
                libraryView
                    .tabItem {
                        Label("Library", systemImage: "play.square.stack")
                    }
                favoritesView
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
            }
            GlobalPlayerView(
                fileName: "imagine",
                url: Bundle.main.url(forResource: "imagine", withExtension: "mp3")
            )
        }
    }

    private var libraryView: some View {
        NavigationSplitView {
            ZStack {
                List {
                    ForEach(items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Button("", systemImage: "play.fill") {
                                // Play song file
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                .navigationBarTitle("Library", displayMode: .large)
                if items.isEmpty {
                    EmptyStateView()
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private var favoritesView: some View {
        NavigationSplitView {
            ZStack {
                List {
                    ForEach(items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Button("", systemImage: "play.fill") {
                                // Play song file
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                .navigationBarTitle("Favorites", displayMode: .large)
                if items.isEmpty {
                    EmptyStateView()
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Music(name: "Music")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    TabBarView()
        .modelContainer(for: Music.self, inMemory: true)
}
