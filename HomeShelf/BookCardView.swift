//
//  BookCardView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 11.06.2023.
//

import SwiftUI

struct BookCardView: View {
    let book: BookEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(nsImage: NSImage.init(data: book.cover!)!)
                .resizable()
                .frame(width: 105, height: 160)
                .padding()
            Text(book.title!)
                .font(.headline)
                .padding(.leading)
            Text(book.author!)
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
