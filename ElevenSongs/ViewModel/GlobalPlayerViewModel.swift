//
//  GlobalPlayerViewModel.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
//

import Foundation
import AVKit

public final class GlobalPlayerViewModel: ObservableObject {
    @Published var globalPlayer: GlobalPlayer = .instance
    public let music: Music

    public init(music: Music) {
        self.music = music
        self.globalPlayer.playingMusic = music
    }

    public func playPause() {
        if globalPlayer.isPlaying {
            globalPlayer.player?.pause()
        } else {
            globalPlayer.player?.play()
        }
        globalPlayer.isPlaying.toggle()
    }

    public func back() {

    }

    public func next() {
        
    }
}
