//
//  PhotoModel.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 23.10.22.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}
