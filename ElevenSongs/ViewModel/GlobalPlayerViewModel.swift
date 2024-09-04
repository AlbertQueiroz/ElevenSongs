//
//  GlobalPlayerViewModel.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
//

import Foundation
import AVKit

public final class GlobalPlayerViewModel: ObservableObject {
    @Published var player: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var totalTime: TimeInterval = 0.0
    @Published var currentTime: TimeInterval = 0.0
    @Published var music: Music

    public init(music: Music) {
        self.music = music
    }

    public func playPause() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()

    }

    public func setupAudio() {
        guard let url = music.url else { return }
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

    public func updateProgress() {
        guard let player = player, player.isPlaying else { return }
        currentTime = player.currentTime
    }
}
