//
//  NewBookView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 09.06.2023.
//

import SwiftUI
import AppKit

struct NewBookView: View {
    @Binding var addBookSheetActivated: Bool
    @State var titleFieldText: String = ""
    @State var coverPictureFilename: String = ""
    
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
                    HStack {
                        Text("Cover")
                            .padding(.trailing)
                        Button(action: imageSelectButtonAction) {
                            Text("Browse...")
                        }
                        if (coverPictureFilename != "") {
                            Image(nsImage: NSImage.init(byReferencingFile: coverPictureFilename)!)
                                .resizable()
                                .frame(width: 50, height: 75).cornerRadius(9)
                        }
                        else {
                            Rectangle()
                                .frame(width: 50, height: 75).cornerRadius(9)
                        }
                    }
                    
                }.padding(.top).frame(width: 270)
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
    
    func imageSelectButtonAction() {
        let panel = NSOpenPanel()
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = false
                if panel.runModal() == .OK {
                    self.coverPictureFilename = panel.url?.path ?? "<none>"
        }
    }
}



struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView(addBookSheetActivated: .constant(true))
    }
}
