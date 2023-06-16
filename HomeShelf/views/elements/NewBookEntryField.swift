//
//  NewBookEntryField.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 16.06.2023.
//

import SwiftUI

struct NewBookEntryField: View {
    var title: String
    var prompt: String
    @Binding var field: String
    
    var body: some View {
        TextField(title, text: $field)
        Text(prompt)
            .padding(.bottom)
    }
}

struct NewBookEntryField_Previews: PreviewProvider {
    static var previews: some View {
        NewBookEntryField(title: "Title", prompt: "", field: .constant("123"))
    }
}
