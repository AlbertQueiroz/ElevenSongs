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
    @State private var showingAlert = false
    @State private var urlString = ""
    private var name: String {
        "\(urlString.split(separator: "=").last ?? "Some music")"
    }
    private var fileUrl: URL? {
        .init(string: urlString)
    }

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
                viewModel: .init(
                    music: .init(
                        name: name,
                        url: fileUrl
                    )
                )
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
                        Button {
                            showingAlert.toggle()
                        } label: {
                            Label("Add Item", systemImage: "plus")
                        }
                        .alert("Add Music", isPresented: $showingAlert) {
                            TextField("URL", text: $urlString)
                            Button("OK", action: addItem)
                        } message: {
                            Text("Enter the song url")
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
        downloadFileFromURL()
        withAnimation {
            let newItem = Music(name: name, url: fileUrl)
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

    func downloadFileFromURL(){
        if let audioUrl = fileUrl {
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)

            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                print("The file already exists at path")
            } else {
                URLSession.shared.downloadTask(
                    with: audioUrl
                ) { location, response, error in
                    guard let location = location, error == nil else { return }
                    do {
                        try FileManager.default.moveItem(
                            at: location,
                            to: destinationUrl
                        )
                        print("File moved to documents folder")
                    } catch {
                        print(error)
                    }
                }.resume()
            }
        }
    }
}

#Preview {
    TabBarView()
        .modelContainer(for: Music.self, inMemory: true)
}
