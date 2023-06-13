//
//  ExploreBookView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 12.06.2023.
//

import SwiftUI

struct ExploreBookView: View {
    @ObservedObject var book: BookEntity
    @State var progressEditSheetActivated = false
    @State var reviewEditSheetActivated = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .top, spacing: 12) {
                Image(nsImage: NSImage.init(data: book.cover)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .frame(maxWidth: 300, maxHeight: .infinity)
                VStack(alignment: .leading, spacing: 8) {
                    Text(book.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    Text(book.author)
                    VStack(alignment: .leading, spacing: 1) {
                        BookRatingView(book: book)
                        Text("My rating")
                            .font(.subheadline)
                    }
                    ProgressView(value: Float(book.progress), total: Float(book.pageCount)) {
                        Text("\(Int(book.progress / (book.pageCount / 100)))% of the book completed.")
                            .font(.subheadline)
                     }
                    HStack {
                        Button(action: updateProgressButtonAction) {
                            Text("Update progress")
                        }.sheet(isPresented: $progressEditSheetActivated) {
                            ProgressEditView(progressEditSheetActivated: $progressEditSheetActivated, book: book)
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
                HStack {
                    Text("My review and thoughts")
                        .font(.title)
                        .fontWeight(.bold)
                    Image(systemName: "pencil")
                        .onTapGesture {
                            reviewEditSheetActivated = true
                        }.sheet(isPresented: $reviewEditSheetActivated) {
                            ReviewEditView(book: book, isReviewEditActivated: $reviewEditSheetActivated)
                        }
                }
                ScrollView {
                    Text(book.review)
                }.frame(minHeight: 100)
            }.padding()
        }.padding().background(.background)
    }
    
    private func updateProgressButtonAction() {
        progressEditSheetActivated = true
    }
}

struct ExploreBookView_Previews: PreviewProvider {
    
    static var previews: some View {
        ExploreBookView(book: BookEntity())
    }
}
