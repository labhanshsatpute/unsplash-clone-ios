import SwiftUI

struct Photo: Decodable, Identifiable {
    let id: String
    let description: String?
    let slug: String?
    let urls: PhotoUrls
    let user: UserData
    let links: PhotoLinks
    struct PhotoUrls: Codable {
        let regular: URL
    }
    struct UserData: Codable {
        let name: String?
        let username: String
        let bio: String?
        let location: String?
        let profile_image: UserProfile
    }
    struct UserProfile: Codable {
        let small: URL?
        let medium: URL?
    }
    struct PhotoLinks: Codable {
        let download: URL
    }
}

struct UnsplashResponse: Decodable {
    let total_pages: Int
    let results: [Photo]
}

struct Search: View {
    
    @State private var searchQuery: String = "";
    @State private var pageNo: Int = 1
    @State private var photos: [Photo] = []
    @State private var totalPages: Int = 0
    @State private var resultNotFound: Bool = false
    
    func showAlert(title: String, message: String) {
        let alertBox = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertBox.addAction(okAction)
        if let view = UIApplication.shared.keyWindow?.rootViewController {
            view.present(alertBox, animated: true)
        }
    }
    
    func searchPhotos() -> Bool {
        
        if searchQuery.isEmpty {
            showAlert(title: "Enter something", message: "Please enter some keyword to search")
            return false
        }
                        
        if let url = URL(string: "https://api.unsplash.com/search/photos/?client_id=Bj9rTPWn7NRhM1NA-V1WWARZXqDl5cywKUN0OHRVYcU&query=\(searchQuery)&page=\(pageNo)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let unsplashResponse = try decoder.decode(UnsplashResponse.self, from: data)
                        if unsplashResponse.total_pages == 0 {
                            self.resultNotFound = true
                        }
                        else {
                            self.resultNotFound = false
                        }
                        DispatchQueue.main.async {
                            self.totalPages = unsplashResponse.total_pages
                            self.photos = unsplashResponse.results
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }.resume()
        }
        
        return true
        
    }
        
    var body: some View {
        
        NavigationView {
            VStack {
                
                VStack (alignment: .center) {
                    Text("Unsplash")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 3)
                    Text("Simply enter keywords or phrases in the box below and discover a world of inspiration at your fingertips")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
                
                HStack {
                    InputBox(text: $searchQuery, placeHolder: "Search Images")
                    Button(action: {
                        searchPhotos()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .foregroundColor(Color.ascent)
                            .frame(width: 20, height: 20)
                    }
                    .padding(14.5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }.padding(.bottom, 10)
                
                
                if resultNotFound {
                    Spacer(minLength: 100)
                    Image(.notFound).resizable().aspectRatio(contentMode: .fit)
                    Text("Result not found!")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.bottom, 5)
                    Text("Didn't found anything matching to your query")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                if searchQuery.isEmpty && resultNotFound == false {
                    Spacer(minLength: 100)
                    Image(.search).resizable().aspectRatio(contentMode: .fit)
                    Text("Search anything")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.bottom, 5)
                    Text("Please any keyword to search the images")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer(minLength: 100)
                }

                VStack {
                    ScrollView {
                        ForEach(photos) { photo in
                            ImageCard(photo: photo )
                        }
                    }.cornerRadius(10)
                        .padding(.bottom, 10)
                }
                
                if photos.count > 1 {
                    HStack {
                        Button(action: {
                            if (pageNo > 1) {
                                pageNo -= 1
                            }
                            searchPhotos()
                        }){
                            HStack {
                                Image(systemName: "arrow.left.circle")
                                Text("Previous")
                                    .font(.footnote)
                                    .fontWeight(.medium)
                            }.frame(maxWidth: .infinity)
                                .padding(13)
                                .foregroundColor(Color.black)
                        }.background(Color.ascent.opacity(0.1))
                            .cornerRadius(10)
                            .disabled(pageNo == 1)
                        
                        Text(String(pageNo))
                            .fontWeight(.medium)
                            .padding(13)
                            .background(Color.ascent.opacity(0.1))
                            .cornerRadius(10)

                        
                        Button(action: {
                            pageNo += 1
                            searchPhotos()
                        }){
                            HStack {
                                Text("Next")
                                    .font(.footnote)
                                    .fontWeight(.medium)
                                Image(systemName: "arrow.right.circle")
                            }.frame(maxWidth: .infinity)
                                .padding(13)
                                .foregroundColor(Color.black)
                        }.background(Color.ascent.opacity(0.1))
                            .cornerRadius(10)
                            .disabled(totalPages == pageNo - 1)
                    }
                }
                
            }.padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Search()
}
