import SwiftUI

struct GetStarted: View {
    
    @State var redirectToSearch = false
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                Image(.getStarted)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text("Unsplash Clone")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title)
                    .padding(.bottom, 5)
                    .foregroundColor(Color.ascent)
                
                Text("Immerse yourself in a vast and diverse library of high-quality stock images sourced from talented photographers and artists worldwide")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("By Labhansh Satpute")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 5)
                         
                NavigationLink(destination: Search(), isActive: $redirectToSearch, label: {
                    ButtonPrimary(label: "Get Started", icon: "arrow.right.circle", handleClick: {
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
