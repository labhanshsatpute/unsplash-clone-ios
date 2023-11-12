//
//  ImageCard.swift
//  Unsplash App
//
//  Created by Labhansh Satpute on 12/11/23.
//

import SwiftUI

struct ImageCard: View {
    
    var url: URL
    var description: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: url) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            if let description = description {
                Text(description)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 5)
            }
            ButtonPrimary(label: "Download", icon: "arrow.down.circle").padding(.top, 5)
        }.padding(.bottom, 10)

    }
}
