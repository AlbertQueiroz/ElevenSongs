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
    @ObservedObject var viewModel: LibraryViewModel


    private var fileUrl: URL? {
        .init(string: viewModel.urlString)
    }

    public init(viewModel: LibraryViewModel = .init()) {
        self.viewModel = viewModel
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
                                GlobalPlayer.instance.play(music: item)
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
            viewModel.showingAlert.toggle()
        } label: {
            Label("Add Item", systemImage: "plus")
        }
        .alert("Add Music", isPresented: $viewModel.showingAlert) {
            TextField("Name", text: $viewModel.name)
            TextField("URL", text: $viewModel.urlString)
            Button("OK", action: addItem)
        } message: {
            Text("Enter the song name and the url")
        }

    }

    private func addItem() {
        withAnimation {
            guard let fileUrl else { return } // Plot error
            let destinationUrl = viewModel.downloadMusic(from: fileUrl)
            let newItem = Music(name: viewModel.name, url: destinationUrl)
            modelContext.insert(newItem)

            viewModel.urlString = ""
            viewModel.name = ""
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let item = items[index]
                modelContext.delete(item)
                guard let url = item.url else { return }
                try? FileManager.default.removeItem(at: url)
                if GlobalPlayer.instance.playingMusic == item {
                    GlobalPlayer.instance.stop()
                }
            }
        }
    }
}

#Preview {
    LibraryView()
}
