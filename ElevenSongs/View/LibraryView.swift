//
//  LibraryView.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
//

import SwiftUI
import SwiftData

struct LibraryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Music]
    @State private var showingAlert = false
    @State private var urlString = ""
    @State private var name: String = ""

    private var fileUrl: URL? {
        .init(string: urlString)
    }

    var body: some View {
        NavigationSplitView {
            ZStack {
                List {
                    ForEach(items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Button("", systemImage: "play.fill") {
                                GlobalPlayer.instance.play(music: .init(
                                    name: "Imagine",
                                    url: Bundle.main.url(forResource: "imagine", withExtension: "mp3")
                                )
                                )
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
                        addMusicButton
                    }
                }
                .navigationBarTitle("Library", displayMode: .large)

                if items.isEmpty {
                    EmptyStateView()
                }
            }
        } detail: {
            Text("Play song")
        }
    }

    private var addMusicButton: some View {
        Button {
            showingAlert.toggle()
        } label: {
            Label("Add Item", systemImage: "plus")
        }
        .alert("Add Music", isPresented: $showingAlert) {
            TextField("Name", text: $name)
            TextField("URL", text: $urlString)
            Button("OK", action: addItem)
        } message: {
            Text("Enter the song name and url")
        }

    }

    private func addItem() {
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

}

#Preview {
    LibraryView()
}
