//
//  GlobalPlayerView.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
//

import SwiftUI

struct GlobalPlayerView: View {

    @ObservedObject private var viewModel: GlobalPlayerViewModel

    init(
        viewModel: GlobalPlayerViewModel
    ) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                HStack {
                    Text(viewModel.music.name)
                    Spacer()
                    Button {
                        viewModel.back()
                    } label: {
                        Label("", systemImage: "backward.fill")
                    }
                    Button {
                        viewModel.playPause()
                    } label: {
                        Label("", systemImage: viewModel.globalPlayer.isPlaying 
                              ? "pause.fill"
                              : "play.fill"
                        )
                    }
                    Button {
                        viewModel.next()
                    } label: {
                        Label("", systemImage: "forward.fill")
                    }

                }
                .padding(24)
                .background(Color.gray.opacity(0.8))
                .cornerRadius(8)
                .padding(16)
                .padding(.bottom, 64)

            }
        }
        .onAppear {
            viewModel.setupAudio()
        }
    }
}

#Preview {
    GlobalPlayerView(
        viewModel: .init(
            music: .init(
                name: "Imagine",
                url: Bundle.main.url(forResource: "imagine", withExtension: "mp3")
            )
        )
    )
}
