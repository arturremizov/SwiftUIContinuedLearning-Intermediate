//
//  SoundsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 8.10.22.
//

import SwiftUI
import AVKit

class SoundManager {
    
    enum SoundOption: String {
        case tada
        case badum
    }
    
    static let instance = SoundManager()
    private init() {}
    
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue,
                                        withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

struct SoundsBootcamp: View {
    var body: some View {
        VStack(spacing: 40.0) {
            Button("Play sound 1") {
                SoundManager.instance.playSound(sound: .tada)
            }
            Button("Play sound 2") {
                SoundManager.instance.playSound(sound: .badum)
            }
        }
    }
}

struct SoundsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundsBootcamp()
    }
}
