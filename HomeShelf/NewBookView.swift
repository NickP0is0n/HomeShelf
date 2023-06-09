//
//  NewBookView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 09.06.2023.
//

import SwiftUI

struct NewBookView: View {
    @State var titleFieldText: String = ""
    
    var body: some View {
        VStack {
            Text("New book")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
            Divider()
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
            }
        
        
    }
}

func dummyButtonAction() {
    
}

struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView()
    }
}
