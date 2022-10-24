//
//  DownloadingImagesRow.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 23.10.22.
//

import SwiftUI

struct DownloadingImagesRow: View {
    
    let model: PhotoModel
    
    var body: some View {
        HStack {
            DownloadingImageView(url: model.url, key: String(model.id))
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                Text(model.url.absoluteString)
                    .foregroundColor(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct DownloadingImagesRow_Previews: PreviewProvider {
    static var previews: some View {
        let model = PhotoModel(
            albumId: 1,
            id: 1,
            title: "accusamus beatae ad facilis cum similique qui sunt",
            url: URL(string: "https://via.placeholder.com/600/92c952")!,
            thumbnailUrl: URL(string: "https://via.placeholder.com/150/92c952")!
        )
        DownloadingImagesRow(model: model)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
