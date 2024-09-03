//
//  GlobalPlayerView.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
//

import SwiftUI

struct GlobalPlayerView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Song name")
                Spacer()
                Button {
                    // Play and Pause song
                } label: {
                    Label("", systemImage: "playpause.fill")
                }
            }
            .padding(24)
            .background(Color.gray.opacity(0.8))
            .cornerRadius(8)
            .padding(16)
            .padding(.bottom, 64)
        }
    }
}

#Preview {
    GlobalPlayerView()
}
