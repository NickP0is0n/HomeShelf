//
//  InProgressView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 13.06.2023.
//

import SwiftUI

struct InProgressView: View {
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
                        if (bookEntity.progress > 0 && bookEntity.progress < bookEntity.pageCount) {
                            Button(action: {
                                bookSelected = bookEntity
                            }) {
                                BookCardView(book: bookEntity)
                            }.buttonStyle(.plain)
                        }
                    }
                }
            }
            .navigationTitle("In process")
        }
        }
}

struct InProgressView_Previews: PreviewProvider {
    static var previews: some View {
        InProgressView()
    }
}
