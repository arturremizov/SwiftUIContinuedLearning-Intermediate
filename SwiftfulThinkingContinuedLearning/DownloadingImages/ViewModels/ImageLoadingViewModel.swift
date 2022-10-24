//
//  ImageLoadingViewModel.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 23.10.22.
//

import Foundation
import UIKit
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    let manager = PhotoModelFileManager.instance
    
    let url: URL
    let imageKey: String
    
    init(url: URL, key: String) {
        self.url = url
        self.imageKey = key
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("Getting saved image!")
        } else {
            print("Downloading image now!")
            downloadImage(url: self.url)
        }
    }
    
    func downloadImage(url: URL) {
        
        isLoading = true
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                guard
                    let self = self,
                    let image else { return }
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
    }
}
