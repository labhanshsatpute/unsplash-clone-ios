import Foundation

class UnsplashController {
    
    static func testAPI() {
        
        if let url = URL(string: "https://api.unsplash.com/photos/?client_id=Bj9rTPWn7NRhM1NA-V1WWARZXqDl5cywKUN0OHRVYcU") {
            URLSession.shared.dataTask(with: url) {
                data, response, error in
                if let data = data {
                    print(data)
                }
                if let response = response {
                    print(response)
                }
                if let error = error {
                    print(error)
                }

            }
        }
    }
    
}
