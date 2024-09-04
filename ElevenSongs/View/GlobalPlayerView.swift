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
                        viewModel.playPause()
                    } label: {
                        Label("", systemImage: "playpause.fill")
                    }
                }
                .padding(24)
                .background(Color.gray.opacity(0.8))
                .cornerRadius(8)
                .padding(16)
                .padding(.bottom, 64)

                Slider(value: Binding(
                    get: {
                        viewModel.currentTime
                    }, set: { newValue in
                        viewModel.player?.currentTime = newValue
                        viewModel.currentTime = newValue
                    }), in: 0...viewModel.totalTime)
                .accentColor(.black)
                .padding(20)
                .padding(.bottom, 4)
                .cornerRadius(24)
            }
        }
        .onAppear {
            viewModel.setupAudio()
        }
        .onReceive(Timer.publish(
            every: 0.01,
            on: .main,
            in: .common
        ).autoconnect()) { _ in
            viewModel.updateProgress()
        }
        .onDisappear {
            viewModel.player?.stop()
        }
    }
}

#Preview {
    GlobalPlayerView(
        viewModel: .init(
        music: .init(
            name: "Imagine",
            url: Bundle.main.url(forResource: "imagine", withExtension: "mp3"))
        )
    )
}
