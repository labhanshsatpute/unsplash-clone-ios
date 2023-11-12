import SwiftUI

struct Photo: Decodable, Identifiable {
    let id: String
    let description: String?
    let slug: String?
    let urls: PhotoUrls
    struct PhotoUrls: Codable {
        let regular: URL
    }
}

struct UnsplashResponse: Decodable {
    let results: [Photo]
}

struct Search: View {
    
    @State private var searchQuery: String = "car";
    @State private var pageNo: Int = 1
    @State private var photos: [Photo] = []
    
    func testAPI() {
        
        if let url = URL(string: "https://api.unsplash.com/search/photos/?client_id=Bj9rTPWn7NRhM1NA-V1WWARZXqDl5cywKUN0OHRVYcU&query=\(searchQuery)&page=\(pageNo)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let unsplashResponse = try decoder.decode(UnsplashResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.photos = unsplashResponse.results
                        }
                        
                        print(unsplashResponse.results)
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }.resume()
        }
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                VStack (alignment: .leading) {
                    Text("Search Images")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 3)
                    Text("Search forn any type of stock images in the world")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.leading, -15)
                .padding(.bottom, 10)
                
                HStack {
                    InputBoxWithButton(text: $searchQuery, placeHolder: "Search Images")
                    Button(action: testAPI) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .padding(13)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }.padding(.bottom, 10)
                
                VStack {
                    ScrollView {
                        ForEach(photos) { photo in
                            if let description = photo.description {
                                ImageCard(url: photo.urls.regular, description: description)
                            }
                            else {
                                ImageCard(url: photo.urls.regular )
                            }
                        }
                    }.cornerRadius(10)
                        .padding(.bottom, 10)
                }
                
                HStack {
                    Button(action: {
                        if (pageNo > 1) {
                            pageNo -= 1
                        }
                        testAPI()
                    }){
                        HStack {
                            Image(systemName: "arrow.left.circle")
                            Text("Previous")
                                .fontWeight(.medium)
                        }.frame(maxWidth: .infinity)
                            .padding(13)
                            .foregroundColor(Color.black)
                    }.background(Color.ascent.opacity(0.1))
                        .cornerRadius(10)
                    
                    Button(action: {
                        pageNo += 1
                        testAPI()
                    }){
                        HStack {
                            Text("Next")
                                .fontWeight(.medium)
                            Image(systemName: "arrow.right.circle")
                        }.frame(maxWidth: .infinity)
                            .padding(13)
                            .foregroundColor(Color.black)
                    }.background(Color.ascent.opacity(0.1))
                        .cornerRadius(10)
                }
                
            }.padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Search()
}
