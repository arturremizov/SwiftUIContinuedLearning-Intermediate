//
//  ArraysBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 10.10.22.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers() {
        let users = [
            UserModel(name: "Nick", points: 5, isVerified: true),
            UserModel(name: "Chris", points: 0, isVerified: false),
            UserModel(name: nil, points: 20, isVerified: true),
            UserModel(name: "Emily", points: 50, isVerified: false),
            UserModel(name: "Samantha", points: 45, isVerified: true),
            UserModel(name: "Jason", points: 12, isVerified: false),
            UserModel(name: "Sarah", points: 76, isVerified: true),
            UserModel(name: nil, points: 45, isVerified: false),
            UserModel(name: "Steve", points: 1, isVerified: true),
            UserModel(name: "Amanda", points: 100, isVerified: false)
        ]
        self.dataArray.append(contentsOf: users)
    }
    
    func updateFilteredArray() {
//        filteredArray = dataArray.sorted { $0.points > $1.points }
//        filteredArray = dataArray.filter { $0.isVerified }
//        mappedArray = dataArray.map { $0.name }
//        mappedArray = dataArray.compactMap { $0.name }
   
        mappedArray = dataArray
                        .sorted { $0.points > $1.points }
                        .filter { $0.isVerified }
                        .compactMap { $0.name }
    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10.0) {
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}
