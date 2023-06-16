//
//  BookRatingView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 12.06.2023.
//

import SwiftUI

struct BookRatingView: View {
    @ObservedObject var book: BookEntity
    @EnvironmentObject var manager: DataController
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        HStack {
            ForEach(1..<6) { i in
                if (i <= Int(book.rating)) {
                    Button(action: {
                        book.rating = Int16(i)
                        saveBook()
                    }) {
                        Image(systemName: "star.fill").contentShape(Rectangle())
                    }.buttonStyle(.plain)
                }
                else {
                    Button(action: {
                        book.rating = Int16(i)
                        saveBook()
                    }) {
                        Image(systemName: "star").contentShape(Rectangle())
                    }.buttonStyle(.plain)
                }
            }
        }
    }
    
    private func saveBook() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

struct BookRatingView_Previews: PreviewProvider {
    static var previews: some View {
        BookRatingView(book: BookEntity())
    }
}
