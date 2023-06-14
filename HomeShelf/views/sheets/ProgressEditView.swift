//
//  ProgressEditView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 12.06.2023.
//

import SwiftUI

struct ProgressEditView: View {
    @EnvironmentObject var manager: DataController
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var progressEditSheetActivated: Bool
    @State private var pageCompleted = ""
    let book: BookEntity
    
    var body: some View {
        VStack {
            Text("Update progress")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
            Divider()
            HStack {
                TextField(text: $pageCompleted) {
                    Text("")
                }
                Text("out of \(book.pageCount).")
            }.padding([.leading, .trailing, .top])
            HStack {
                Button(action: okButtonAction, label: {
                    Text("OK")
                })
                Button(action: cancelButtonAction, label: {
                    Text("Cancel")
                })
            }.padding()
        }.frame(minWidth: 200)
        
    }
    
    private func okButtonAction() {
        book.progress = Int16(pageCompleted)!
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        progressEditSheetActivated = false
    }
    
    private func cancelButtonAction() {
        progressEditSheetActivated = false
    }
}

struct ProgressEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressEditView(progressEditSheetActivated: .constant(true), book: BookEntity())
    }
}