//
//  LibraryViewModel.swift
//  ElevenSongs
//
//  Created by Albert on 04/09/24.
//

import Foundation
import SwiftData

public final class LibraryViewModel: ObservableObject {
    @Published public var showingAlert = false
    @Published public var urlString = ""
    @Published public var name: String = ""

    private let downloadMusicUseCase: DownloadMusicUseCasing

    public init(
        downloadMusicUseCase: DownloadMusicUseCasing = DownloadMusicUseCase()
    ) {
        self.downloadMusicUseCase = downloadMusicUseCase
    }

    func downloadMusic(from url: URL) -> URL {
        downloadMusicUseCase.execute(from: url)
    }
}
