//
//  ExploreBookView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 12.06.2023.
//

import SwiftUI

struct ExploreBookView: View {
    @Binding var book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .top, spacing: 12) {
                Image(nsImage: book.cover)
                VStack(alignment: .leading, spacing: 8) {
                    Text(book.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    Text(book.author)
                    VStack(alignment: .leading, spacing: 1) {
                        BookRatingView(bookRating: book.rating)
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
                    }
                }
            }.padding()
            VStack(alignment: .leading) {
                Text("My review and thoughts")
                    .font(.title)
                    .fontWeight(.bold)
                ScrollView {
                    Text(book.review)
                }.frame(minHeight: 100)
            }.padding()
            
        }.padding()
    }
}

struct ExploreBookView_Previews: PreviewProvider {
    
    static var previews: some View {
        ExploreBookView(book: .constant(Book(title: "Sample book", author: "Sample author", cover: NSImage(named: NSImage.Name("sample_book"))!, pageCount: 300, storeLink: "http://samplestore.com/", rating: 3, review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec lorem nisl, iaculis sit amet tempor nec, rhoncus eget arcu. Sed ullamcorper ipsum at nunc mollis, vitae suscipit orci scelerisque. Donec nec pulvinar eros. Sed felis elit, iaculis et euismod eu, vehicula sed dolor. Pellentesque odio eros, congue a vulputate ultricies, auctor eget ex. Mauris mollis nulla elit, non sollicitudin risus placerat vitae. Curabitur id est ac sapien lobortis accumsan a et eros. In venenatis quam ut ipsum sollicitudin, nec commodo felis laoreet. Vivamus euismod turpis quis auctor consequat. Morbi iaculis nulla nec velit interdum volutpat. Sed pretium lectus a porttitor dictum.")))
    }
}
