//
//  DownloadMusicUseCase.swift
//  ElevenSongs
//
//  Created by Albert on 04/09/24.
//

import Foundation

public protocol DownloadMusicUseCasing {
    func execute(from url: URL) -> URL
}

public final class DownloadMusicUseCase: DownloadMusicUseCasing {

    public init() {}
    
    public func execute(from url: URL) -> URL{
        let documentsDirectoryURL =  FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!
        let destinationUrl = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)

        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            print("The file already exists at path")
        } else {
            URLSession.shared.downloadTask(
                with: url
            ) { location, response, error in
                guard let location = location, error == nil else { return }
                do {
                    try FileManager.default.moveItem(at: location, to: destinationUrl)
                    print("File moved to documents folder")
                } catch {
                    print(error)
                }
            }.resume()
        }
        return destinationUrl

    }
}
