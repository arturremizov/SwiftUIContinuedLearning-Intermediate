//
//  DownloadingImagesViewModel.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 23.10.22.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataService = PhotoModelDataService.instance
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] photoModels in
                self?.dataArray = photoModels
            }
            .store(in: &cancellables)
    }
}
