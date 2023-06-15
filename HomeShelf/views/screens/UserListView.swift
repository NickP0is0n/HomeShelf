//
//  UserListView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 14.06.2023.
//

import SwiftUI

struct UserListView: View {
    let listName: String
    @FetchRequest(sortDescriptors: []) private var bookEntities: FetchedResults<BookEntity>
    @State var bookSelected: BookEntity? = nil
    
    let columns = [
            GridItem(.adaptive(minimum: 150))
        ]
    
    var body: some View {
        if (bookSelected != nil) {
            ExploreBookView(book: bookSelected!)
                .navigationTitle("\(bookSelected?.title ?? "") by \(bookSelected?.author ?? "")")
                .toolbar {
                    ToolbarItem(placement: .navigation){
                        Button(action: {
                            bookSelected = nil
                        }, label: {
                            Image(systemName: "chevron.left")
                        })
                    }
                }
        }
        else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(bookEntities) { bookEntity in
                        if (bookEntity.inUserList.contains(listName)) {
                            Button(action: {
                                bookSelected = bookEntity
                            }) {
                                BookCardView(book: bookEntity)
                            }.buttonStyle(.plain).focusable()
                        }
                    }
                }
            }
            .navigationTitle(listName)
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(listName: "")
    }
}
