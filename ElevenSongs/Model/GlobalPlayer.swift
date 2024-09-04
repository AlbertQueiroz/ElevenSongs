//
//  GlobalPlayer.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
//

import Foundation
import AVKit

public final class GlobalPlayer: ObservableObject {
    public static var instance = GlobalPlayer()
    @Published var isPlaying = false
    
    var player: AVPlayer?
    var playingMusic: Music?

    private init() {}

    public func play(music: Music) {
        isPlaying = true
        player?.pause()
        self.playingMusic = music
        if let player = player,
           let url = music.url {
            player.replaceCurrentItem(with: .init(url: url))
            player.play()
        } else {
            setupAudio()
        }
    }

    public func stop() {
        player?.pause()
        isPlaying = false
    }

    public func setupAudio() {
        guard let url = playingMusic?.url else { return }
        do {
            player = AVPlayer(url: url)
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            player?.play()
        } catch {
            print("Error loading audio: \(error)")
        }
    }
}
