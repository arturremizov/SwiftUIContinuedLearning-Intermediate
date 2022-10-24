//
//  EscapingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 16.10.22.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    @Published var text: String = "Hello"
    
    func getData() {
        downloadData5 { [weak self] result in
            self?.text = result.data
        }
    }
    
    func downloadData() -> String {
        return "New Data!"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> Void) {
        completionHandler("New Data!")
    }
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("New Data!")
        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data!")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompetion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data!")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompetion = (DownloadResult) -> Void

struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
