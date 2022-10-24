//
//  CacheBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 19.10.22.
//

import SwiftUI

class CacheManager {
    
    static let instance = CacheManager()
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
        return cache
    }()
    
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to cache!"
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from cache!"
    }
    
    func get(name: String) -> UIImage? {
        imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage: String = ""
    let imageName: String = "steve-jobs"
    let manager = CacheManager.instance
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        if let image = manager.get(name: imageName) {
            cachedImage = image
            infoMessage = "Got image from Cache"
        } else {
            infoMessage = "Image not found in Cache"
        }
    }
}

struct CacheBootcamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
         
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundColor(.purple)
                
                HStack {
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("Save to Cache")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(height: 40)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        vm.removeFromCache()
                    } label: {
                        Text("Delete to Cache")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(height: 40)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
                
                Button {
                    vm.getFromCache()
                } label: {
                    Text("Get from Cache")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(height: 40)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

struct CacheBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CacheBootcamp()
    }
}
