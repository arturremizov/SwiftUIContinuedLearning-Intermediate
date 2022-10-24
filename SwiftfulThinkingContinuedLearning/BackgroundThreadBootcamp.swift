//
//  BackgroundThreadBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 12.10.22.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("CHECK 1: \(Thread.isMainThread)")
            print("CHECK 1: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                print("CHECK 2: \(Thread.isMainThread)")
                print("CHECK 2: \(Thread.current)")
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        for i in 0..<100 {
            data.append("\(i)")
            print(data)
        }
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10.0) {
                Text("Load data".uppercased())
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}
