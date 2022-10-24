//
//  FileManagerBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 19.10.22.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    
    private init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                                .default
                                .urls(for: .cachesDirectory, in: .userDomainMask)
                                .first?
                                .appending(path: folderName)
                                .path() else {
            return
        }
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("Success creating folder.")
            } catch {
                print("Error creating folder. \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                                .default
                                .urls(for: .cachesDirectory, in: .userDomainMask)
                                .first?
                                .appending(path: folderName)
                                .path() else {
            return
        }
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder")
        } catch {
            print("Error deleting folder. \(error)")
        }
    }
    
    func saveImage(_ image: UIImage, name: String) -> String {
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
           
            return "Error getting data."
        }
        do {
            try data.write(to: path)
            print(path)
            return "Success saving!"
        } catch {
            return "Error saving. \(error)"
        }
    }
    
    func getImage(_ name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Error getting path.")
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        guard
            let path = getPathForImage(name: name)?.path(),
            FileManager.default.fileExists(atPath: path) else {
            return "Error getting path."
        }
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Succesfully deleted."
        } catch {
            return "Error deleting image. \(error)"
        }
    }
    
    func getPathForImage(name: String) -> URL? {
        let path = FileManager
                            .default
                            .urls(for: .cachesDirectory, in: .userDomainMask)
                            .first?
                            .appending(component: folderName)
                            .appending(path: "\(name).jpg")
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName: String = "steve-jobs"
    let mamager = LocalFileManager.instance
    @Published var infoMessage: String = ""
    
    init() {
        getImageFromAssetsFolder()
//        getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = mamager.getImage(imageName)
    }
    
    func saveImage() {
        guard let image else { return }
        infoMessage = mamager.saveImage(image, name: imageName)
    }
    
    func deleteImage() {
        infoMessage = mamager.deleteImage(name: imageName)
        mamager.deleteFolder()
    }
}

struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to FM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete from FM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp()
    }
}
