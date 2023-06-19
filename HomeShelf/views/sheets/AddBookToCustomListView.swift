//
//  AddBookToCustomListView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 14.06.2023.
//

import SwiftUI

struct AddBookToCustomListView: View {
    @EnvironmentObject var manager: DataController
    @Environment(\.managedObjectContext) private var viewContext
    let book: BookEntity
    @ObservedObject var dataModel: DataModel
    @State var isActive: Bool = false
    @Binding var isBookListEditorActivated: Bool
    
    var body: some View {
        VStack {
            Text("Add book to list")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
            Divider()
            if(dataModel.toggles.isEmpty) {
                Text("Loading...")
            } else {
                List {
                    ForEach(self.dataModel.toggles, id: \.self) { model in
                        Toggle(model.title, isOn: Binding<Bool>(
                            get: { model.isActive },
                            set: {
                                if let index = dataModel.toggles.firstIndex(where: { $0.id == model.id }) {
                                    dataModel.toggles[index] = ToggleModel(
                                        id: model.id, title: model.title, isActive: $0)
                                }
                            }
                        ))
                    }
                }.padding()
            }
            
            HStack {
                Button(action: okButtonAction) {
                    Text("OK")
                }.keyboardShortcut(.defaultAction)
                Button(action: cancelButtonAction) {
                    Text("Cancel")
                }.keyboardShortcut(.cancelAction)
            }.padding()
        }.frame(minWidth: 400, minHeight: 400)
            .onAppear {
                for (index, _) in dataModel.toggles.enumerated() {
                    if (book.inUserList.contains(dataModel.toggles[index].title)) {
                        dataModel.toggles[index].isActive = true
                    }
                }
        }
    }
    
    private func okButtonAction() {
        var customLists: [String] = []
        dataModel.toggles.forEach { toggle in
            if (toggle.isActive) {
                customLists.append(toggle.title)
            }
        }
        book.inUserList = customLists
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        isBookListEditorActivated = false
    }
    
    private func cancelButtonAction() {
        isBookListEditorActivated = false
    }
}

struct AddBookToCustomListView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookToCustomListView(book: BookEntity(), dataModel: DataModel(toggles: [
            ToggleModel(id: 1, title: "List 1", isActive: true),
            ToggleModel(id: 2, title: "List 2", isActive: false),
            ToggleModel(id: 3, title: "List 3", isActive: true),
        ]), isBookListEditorActivated: .constant(true))
    }
}
