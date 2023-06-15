//
//  BookCardView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 11.06.2023.
//

import SwiftUI

struct BookCardView: View {
    let book: BookEntity
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading) {
            if (colorScheme == .dark) {
                Image(nsImage: NSImage.init(data: book.cover)!)
                    .resizable()
                    .frame(width: 115, height: 170)
                    .shadow(color: Color(NSImage.init(data: book.cover)!.averageColor ?? NSColor(Color.white)), radius: 10, y: 5)
                    .padding()
            }
            else {
                Image(nsImage: NSImage.init(data: book.cover)!)
                    .resizable()
                    .frame(width: 115, height: 170)
                    .shadow(radius: 10)
                    .padding()
            }
            
            if (book.isFavorite) {
                Text("\(book.title) 􀊵")
                    .font(.headline)
                    .padding(.leading)
            }
            else {
                Text(book.title)
                    .font(.headline)
                    .padding(.leading)
            }
            Text(book.author)
                .font(.body)
                .padding([.leading, .bottom])
        }
    }
}

struct BookCardView_Previews: PreviewProvider {
    static var previews: some View {
        BookCardView(book: BookEntity())
    }
}
