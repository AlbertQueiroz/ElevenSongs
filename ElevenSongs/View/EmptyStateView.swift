//
//  EmptyStateView.swift
//  ElevenSongs
//
//  Created by Albert on 03/09/24.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image(.emptyState)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 164)
            Text("There are no songs here yet!!!")
                .font(.title3)
                .fontWeight(.light)
        }
        .padding(.bottom, 64)
    }
}

#Preview {
    EmptyStateView()
}
