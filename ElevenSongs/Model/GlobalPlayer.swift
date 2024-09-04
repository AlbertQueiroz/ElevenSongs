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
    
    var player: AVAudioPlayer?
    var playingMusic: Music?

    private init() {}

    public func play(music: Music) {
        self.playingMusic = music
        player?.play()
        isPlaying = true
    }

    public func setupAudio() {
        guard let url = playingMusic?.url else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error loading audio: \(error)")
        }
    }
}
