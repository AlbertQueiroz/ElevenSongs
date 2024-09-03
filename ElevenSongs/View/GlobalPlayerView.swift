//
//  GlobalPlayerView.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
//

import SwiftUI
import AVKit

struct GlobalPlayerView: View {

    private let fileName: String?
    private let url: URL?

    @State private var player: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0

    init(
        fileName: String? = nil,
        url: URL? = nil
    ) {
        self.fileName = fileName
        self.url = url
    }

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                HStack {
                    Text("Song name")
                    Spacer()
                    Button {
                        if isPlaying {
                            player?.pause()
                            isPlaying = false
                        } else {
                            player?.play()
                            isPlaying = true
                        }
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
                        currentTime
                    }, set: { newValue in
                        player?.currentTime = newValue
                        currentTime = newValue
                    }), in: 0...totalTime)
                .accentColor(.black)
                .padding(20)
                .padding(.bottom, 4)
                .cornerRadius(24)
            }
        }
        .onAppear {
            if let url = url {
                setupAudio(withURL: url)
            }
        }
        .onReceive(Timer.publish(
            every: 0.01,
            on: .main,
            in: .common
        ).autoconnect()) { _ in
            updateProgress()
        }
        .onDisappear {
            player?.stop()
        }
    }

    private func setupAudio(withURL url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            totalTime = player?.duration ?? 0.0
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error loading audio: \(error)")
        }
    }

    private func updateProgress() {
        guard let player = player, player.isPlaying else { return }
        currentTime = player.currentTime
    }
}

#Preview {
    GlobalPlayerView(
        fileName: "imagine",
        url: Bundle.main.url(forResource: "imagine", withExtension: "mp3")
    )
}
