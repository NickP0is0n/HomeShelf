//
//  NewBookView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 09.06.2023.
//

import SwiftUI
import AppKit
import CoreData

struct NewBookView: View {
    @EnvironmentObject var manager: DataController
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var addBookSheetActivated: Bool
    @State var titleFieldText: String = ""
    @State var authorFieldText: String = ""
    @State var pageCountText: String = ""
    @State var storeLinkText: String = ""
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
                    TextField("Author", text: $authorFieldText)
                        .padding(.bottom)
                    TextField("Page count", text: $pageCountText)
                        .padding(.bottom)
                    TextField("Store link", text: $storeLinkText)
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
                    Button(action: cancelButtonAction) {
                        Text("Cancel")
                    }
                    .padding([.leading, .bottom])
                    Button(action: okButtonAction) {
                        Text("OK")
                    }
                    .padding([.bottom, .trailing])
                }
            }.frame(width: 400)
        
    }
    
    func cancelButtonAction() {
        addBookSheetActivated = false
    }
    
    func okButtonAction() {
        saveBook()
        addBookSheetActivated = false
    }
    
    func saveBook() {
        let newBookEntity = BookEntity(context: viewContext)
        newBookEntity.title = titleFieldText
        newBookEntity.author = authorFieldText
        newBookEntity.cover = NSImage.init(byReferencingFile: coverPictureFilename)!.tiffRepresentation!
        newBookEntity.pageCount = Int16(pageCountText) ?? 0
        newBookEntity.storeUrl = storeLinkText
        newBookEntity.progress = 0
        newBookEntity.isFavorite = false
        newBookEntity.loanedTo = ""
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
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
