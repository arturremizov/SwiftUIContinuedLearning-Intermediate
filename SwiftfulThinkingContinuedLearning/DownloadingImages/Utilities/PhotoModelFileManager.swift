//
//  PhotoModelFileManager.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 23.10.22.
//

import Foundation
import UIKit

class PhotoModelFileManager {
    
    static let instance = PhotoModelFileManager()
    let folderName = "downloaded_photos"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        if !FileManager.default.fileExists(atPath: url.path()) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                print("Created folder!")
            } catch {
                print("Error creating folder.", error)
            }
        }
        
    }
    
    private func getFolderPath() -> URL? {
        FileManager
            .default
            .urls(for: .cachesDirectory,
                 in: .userDomainMask)
            .first?
            .appending(path: folderName)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folderPath = getFolderPath() else { return nil }
        return folderPath.appending(path: key + ".png")
    }
    
    func add(key: String, value: UIImage) {
        guard
            let data = value.pngData(),
            let url = getImagePath(key: key) else { return }
        
        do {
            try data.write(to: url)
        } catch {
            print("Error saving to file manager.", error)
        }
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path()) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path())
    }
}
