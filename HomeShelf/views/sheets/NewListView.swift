//
//  NewListView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 14.06.2023.
//

import SwiftUI

struct NewListView: View {
    @EnvironmentObject var manager: DataController
    @Environment(\.managedObjectContext) private var viewContext
    @State private var listName = ""
    @Binding var isNewListSheetActivated: Bool
    
    var body: some View {
        VStack {
            Text("New list")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
            Divider()
            HStack {
                TextField(text: $listName) {
                    Text("Name of the list")
                }
            }.padding([.leading, .trailing, .top])
            HStack {
                Button(action: okButtonAction, label: {
                    Text("OK")
                }).keyboardShortcut(.defaultAction)
                Button(action: cancelButtonAction, label: {
                    Text("Cancel")
                }).keyboardShortcut(.cancelAction)
            }.padding()
        }.frame(minWidth: 200)
    }
    
    private func okButtonAction() {
        if (!listName.isEmpty) {
            let newList = UserListEntity(context: viewContext)
            newList.listName = listName
            do {
                try viewContext.save()
            } catch {
                viewContext.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            isNewListSheetActivated = false
        }
    }
    
    private func cancelButtonAction() {
        isNewListSheetActivated = false
    }
}

struct NewListView_Previews: PreviewProvider {
    static var previews: some View {
        NewListView(isNewListSheetActivated: .constant(true))
    }
}
