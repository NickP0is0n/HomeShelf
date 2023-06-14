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
    
    var body: some View {
            VStack(alignment: .leading) {
                Text("New list")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Divider()
                HStack {
                    TextField(text: $listName) {
                        Text("List name")
                    }
                }.padding([.leading, .trailing, .top])
                HStack {
                    Button(action: okButtonAction, label: {
                        Text("Save")
                    })
                }.padding()
                Spacer()
            }
    }
    
    private func okButtonAction() {
        let newList = UserListEntity(context: viewContext)
        newList.listName = listName
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

struct NewListView_Previews: PreviewProvider {
    static var previews: some View {
        NewListView()
    }
}
