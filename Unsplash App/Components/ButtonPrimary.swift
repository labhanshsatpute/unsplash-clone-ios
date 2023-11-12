import SwiftUI

struct ButtonPrimary: View {
    
    var label: String
    var icon: String?
    var handleClick: (() -> Void)?
    
    var body: some View {
        Button(action: {
            if let handleClick = handleClick {
                self.handleClick?()
            }
        }) {
            HStack {
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.medium)
                if let icon = icon {
                    Image(systemName: icon)
                        .resizable()
                        .frame(width: 15, height: 15)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 13)
            .padding(.horizontal, 20)
        }
        .background(Color("Ascent"))
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}
