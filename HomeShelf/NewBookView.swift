//
//  NewBookView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 09.06.2023.
//

import SwiftUI

struct NewBookView: View {
    @Binding var addBookSheetActivated: Bool
    @State var titleFieldText: String = ""
    
    var body: some View {
        VStack {
            Text("New book")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
            Divider()
            HStack {
                Form {
                    TextField("Title", text: $titleFieldText)
                        .padding(.bottom)
                    TextField("Author", text: $titleFieldText)
                        .padding(.bottom)
                    TextField("Page count", text: $titleFieldText)
                        .padding(.bottom)
                    TextField("Store link", text: $titleFieldText)
                        .padding(.bottom)
                    Text("Cover")
                        .padding(.bottom)
                }.frame(width: 270)
            }
                HStack {
                    Spacer()
                    Button(action: dummyButtonAction) {
                        Text("Cancel")
                    }
                    .padding([.leading, .bottom])
                    Button(action: dummyButtonAction) {
                        Text("OK")
                    }
                    .padding([.bottom, .trailing])
                }
            }.frame(width: 400)
        
    }
    
    func dummyButtonAction() {
        addBookSheetActivated = false
    }
}



struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView(addBookSheetActivated: .constant(true))
    }
}
