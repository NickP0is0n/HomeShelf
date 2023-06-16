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
    @ObservedObject var newBookViewModel = NewBookViewModel()
    
    var body: some View {
        VStack {
            Text("New book")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
            Divider()
            VStack(alignment: .leading) {
                Form {
                    NewBookEntryField(title: "Title", prompt: newBookViewModel.titleErrorPrompt, field: $newBookViewModel.title)
                    NewBookEntryField(title: "Author", prompt: newBookViewModel.authorErrorPrompt, field: $newBookViewModel.author)
                    NewBookEntryField(title: "Page count", prompt: newBookViewModel.pageCountErrorPrompt, field: $newBookViewModel.pageCount)
                    NewBookEntryField(title: "Store link", prompt: "", field: $newBookViewModel.storeLink)
                }.padding(.top).frame(width: 450)
                HStack {
                    Text("Cover")
                        .padding(.leading)
                    if (!newBookViewModel.isCoverPictureEmpty()) {
                        Button(action: imageSelectButtonAction) {
                            Image(nsImage: NSImage.init(byReferencingFile: newBookViewModel.coverPictureFilename)!)
                                .resizable()
                                .frame(width: 50, height: 75).cornerRadius(9)
                                .padding(.leading)
                        }.buttonStyle(.plain).focusable()
                    }
                    else {
                        Button(action: imageSelectButtonAction) {
                            Rectangle()
                                .frame(width: 50, height: 75).cornerRadius(9)
                                .padding(.leading)
                        }.buttonStyle(.plain).focusable()
                    }
                    Text(newBookViewModel.coverPictureErrorPrompt)
                        .padding(.leading)
                }
            }
                HStack {
                    Spacer()
                    Button(action: cancelButtonAction) {
                        Text("Cancel")
                    }.keyboardShortcut(.cancelAction)
                    .padding([.leading, .bottom])
                    .focusable()
                    Button(action: okButtonAction) {
                        Text("OK")
                    }.keyboardShortcut(.defaultAction)
                    .padding([.bottom, .trailing])
                    .focusable()
                }
            }.frame(width: 500)
        
    }
    
    func cancelButtonAction() {
        addBookSheetActivated = false
    }
    
    func okButtonAction() {
        if (newBookViewModel.isModelValid()) {
            saveBook()
            addBookSheetActivated = false
        }
    }
    
    func saveBook() {
        let newBookEntity = BookEntity(context: viewContext)
        newBookEntity.title = newBookViewModel.title
        newBookEntity.author = newBookViewModel.author
        newBookEntity.cover = NSImage.init(byReferencingFile: newBookViewModel.coverPictureFilename)!.tiffRepresentation!
        newBookEntity.pageCount = Int16(newBookViewModel.pageCount) ?? 0
        newBookEntity.storeUrl = newBookViewModel.storeLink
        newBookEntity.progress = 0
        newBookEntity.isFavorite = false
        newBookEntity.loanedTo = ""
        newBookEntity.inUserList = []
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
                    newBookViewModel.coverPictureFilename = panel.url?.path ?? "<none>"
        }
    }
}



struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView(addBookSheetActivated: .constant(true))
    }
}
