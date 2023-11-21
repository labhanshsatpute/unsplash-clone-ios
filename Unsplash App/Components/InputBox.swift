//
//  InputBoxWithButton.swift
//  Unsplash App
//
//  Created by Labhansh Satpute on 12/11/23.
//

import SwiftUI

struct InputBox: View {
    
    @Binding var text: String
    var placeHolder: String
    
    var body: some View {
        TextField(placeHolder, text: $text)
            .padding(.horizontal, 15)
            .padding(.vertical, 13)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
    }
}
