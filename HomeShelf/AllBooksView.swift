//
//  AllBooksView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 08.06.2023.
//

import SwiftUI

struct AllBooksView: View {
    @State var addBookSheetActivated = false
    @EnvironmentObject var manager: DataController
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var bookEntities: FetchedResults<BookEntity>
    @State var bookSelected: Book? = nil
    
    let columns = [
            GridItem(.adaptive(minimum: 150))
        ]
    
    var body: some View {
        if (bookSelected != nil) {
            ExploreBookView(book: bookSelected!)
                .navigationTitle("\(bookSelected!.title) by \(bookSelected!.author)")
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
                        let book = Book(title: bookEntity.title ?? "", author: bookEntity.author ?? "", cover: NSImage.init(data: bookEntity.cover!) ?? NSImage(), pageCount: Int(bookEntity.pageCount), storeLink: bookEntity.storeUrl ?? "")
                        BookCardView(book: book).onTapGesture {
                            bookSelected = book
                        }
                    }
                }.background(.background)
            }
            .navigationTitle("All books")
            .toolbar {
                ToolbarItem(placement: .navigation){
                    Button(action: addBook, label: {
                        Image(systemName: "plus.app")
                    }).sheet(isPresented: $addBookSheetActivated) {
                        NewBookView(addBookSheetActivated: $addBookSheetActivated)
                    }
                }
            }
        }
        }
        
    
    func addBook() {
        addBookSheetActivated.toggle()
    }
}


struct AllBooksView_Previews: PreviewProvider {
    static var previews: some View {
        AllBooksView()
    }
}
