//
//  ExploreBookView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 12.06.2023.
//

import SwiftUI

struct ExploreBookView: View {
    let book: BookEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .top, spacing: 12) {
                Image(nsImage: NSImage.init(data: book.cover!)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .frame(maxWidth: 300, maxHeight: .infinity)
                VStack(alignment: .leading, spacing: 8) {
                    Text(book.title!)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    Text(book.author!)
                    VStack(alignment: .leading, spacing: 1) {
                        BookRatingView(book: book)
                        Text("My rating")
                            .font(.subheadline)
                    }
                    /*ProgressView(value: Float(100), total: Float(book.pageCount)) {
                        Text("Progress")
                            .font(.subheadline)
                     }*/ //TODO:Make proper progress
                    HStack {
                        Button(action: {
                            
                        }) {
                            Text("Update progress")
                        }
                        Button(action: {
                            
                        }) {
                            Text("Add to list")
                        }
                        Button(action: {
                            
                        }) {
                            Text("Loan book")
                        }
                    }.padding(.top)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }.padding()
            VStack(alignment: .leading) {
                Text("My review and thoughts")
                    .font(.title)
                    .fontWeight(.bold)
                ScrollView {
                    Text(book.review!)
                }.frame(minHeight: 100)
            }.padding()
        }.padding()
    }
}

struct ExploreBookView_Previews: PreviewProvider {
    
    static var previews: some View {
        ExploreBookView(book: BookEntity())
    }
}
