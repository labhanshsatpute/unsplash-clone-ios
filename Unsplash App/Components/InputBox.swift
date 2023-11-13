//
//  InputBoxWithButton.swift
//  Unsplash App
//
//  Created by Labhansh Satpute on 12/11/23.
//

import SwiftUI

struct InputBoxWithButton: View {
    
    @Binding var text: String
    var placeHolder: String
    var keyUp: () -> Void
    
    var body: some View {
        TextField(placeHolder, text: $text, onEditingChanged: { isEditing in if !isEditing {
            self.keyUp()
            }
        })
            .padding(.horizontal, 15)
            .padding(.vertical, 13)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
    }
}
