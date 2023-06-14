//
//  LoanedBooksListView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 14.06.2023.
//

import SwiftUI

struct LoanedBooksListView: View {
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
                        if (!bookEntity.loanedTo.isEmpty) {
                            VStack(spacing:0) {
                                BookCardView(book: bookEntity).onTapGesture {
                                    bookSelected = bookEntity
                                }
                                Text("Loaned to \(bookEntity.loanedTo)")
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }.background(.background)
            }
            .navigationTitle("Favorite books")
        }
    }
}

struct LoanedBooksListView_Previews: PreviewProvider {
    static var previews: some View {
        LoanedBooksListView()
    }
}
