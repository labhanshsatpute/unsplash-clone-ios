//
//  ImageCard.swift
//  Unsplash App
//
//  Created by Labhansh Satpute on 12/11/23.
//

import SwiftUI

struct ImagePreview: View {
    
    @Environment(\.dismiss) var dismiss
    
    var photo: Photo
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    AsyncImage(url: photo.urls.regular) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }.padding(.bottom, 10)
                    if let description = photo.description {
                        Text(description)
                            .font(.title3)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5)
                    }
                }.padding(.bottom, 12)
                VStack(alignment: .leading) {
                    if let userFullName = photo.user.name {
                        HStack(alignment: .center) {
                            if let userProfileMedium = photo.user.profile_image.medium {
                                AsyncImage(url: userProfileMedium).clipped().frame(width: 40, height: 40).cornerRadius(50)
                            }
                            VStack(alignment: .leading) {
                                Text(userFullName)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                Text(photo.user.username)
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)

                            }
                        }.padding(.bottom, 10)
                    }
                    if let userBio = photo.user.bio {
                        HStack(alignment: .top) {
                            Image(systemName: "info.circle")
                                .foregroundColor(.gray)
                            Text(userBio)
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.gray)
                        }.padding(.bottom, 10)
                    }
                    if let userLocation = photo.user.location {
                        HStack(alignment: .top) {
                            Image(systemName: "location.circle")
                                .foregroundColor(.gray)
                            Text(userLocation)
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.gray)
                        }
                    }
                }.padding(.bottom, 10)
                ButtonPrimary(label: "Download Image", icon: "arrow.down.circle")
                Spacer()
            }.padding(20)
        }.padding(.vertical, 20)
    }
}


struct ImageCard: View {
    
    var photo: Photo
    
    @State private var showPreview = false
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: photo.urls.regular) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }
            if let description = photo.description {
                Text(description)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 5)
            }
            ButtonPrimary(label: "Learn more", icon: "info.circle", handleClick: {
                showPreview.toggle()
            }).padding(.top, 5).sheet(isPresented: $showPreview, content: {
                ImagePreview(photo: photo).cornerRadius(20)
            })
        }.padding(.bottom, 10)

    }
}
