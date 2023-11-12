import SwiftUI

struct GetStarted: View {
    
    @State var redirectToSearch = false
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                Image(.getStartedPng)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text("Let's Get Started")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title)
                    .padding(.bottom, 5)
                
                Text("Get the best stock image from unsplash")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                         
                NavigationLink(destination: Search(), isActive: $redirectToSearch, label: {
                    ButtonPrimary(label: "Continue", icon: "arrow.right.circle", handleClick: {
                        redirectToSearch = true
                    })
                })

            }.padding(20)
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GetStarted()
}
