//
//  ExploreBookView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 12.06.2023.
//

import SwiftUI

struct ExploreBookView: View {
    @ObservedObject var book: BookEntity
    @EnvironmentObject var manager: DataController
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    @FetchRequest(sortDescriptors: []) private var userListEntities: FetchedResults<UserListEntity>
    @State var progressEditSheetActivated = false
    @State var reviewEditSheetActivated = false
    @State var bookLoanSheetActivated = false
    @State var addBookToListSheetActivated = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .top, spacing: 12) {
                if (colorScheme == .dark) {
                    Image(nsImage: NSImage.init(data: book.cover)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .shadow(color: Color(NSImage.init(data: book.cover)!.averageColor ?? NSColor(Color.white)), radius: 10, y: 5)
                        .frame(maxWidth: 300, maxHeight: .infinity)
                }
                else {
                    Image(nsImage: NSImage.init(data: book.cover)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .shadow(radius: 10)
                        .frame(maxWidth: 300, maxHeight: .infinity)
                }
                VStack(alignment: .leading, spacing: 8) {
                    HStack() {
                        Text(book.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top)
                        if (book.isFavorite) {
                            Button(action: {
                                book.isFavorite = false
                                saveBook()
                            }) {
                                Image(systemName: "heart.fill")
                                    .padding(.top)
                                    .contentShape(Rectangle())
                            }.buttonStyle(.plain)
                        }
                        else {
                            Button(action: {
                                book.isFavorite = true
                                saveBook()
                            }) {
                                Image(systemName: "heart")
                                    .padding(.top)
                                    .contentShape(Rectangle())
                            }.buttonStyle(.plain)
                        }
                    }
                    Text(book.author)
                    if (!book.loanedTo.isEmpty) {
                        Text("Loaned to \(book.loanedTo)")
                            .fontWeight(.bold)
                    }
                    VStack(alignment: .leading, spacing: 1) {
                        BookRatingView(book: book)
                        Text("My rating")
                            .font(.subheadline)
                    }
                    ProgressView(value: Float(book.progress), total: Float(book.pageCount)) {
                        Text("\(Int(Double(book.progress) / (Double(book.pageCount) / 100)))% of the book completed.")
                            .font(.subheadline)
                     }
                    HStack {
                        Button(action: updateProgressButtonAction) {
                            Text("Update progress")
                        }.sheet(isPresented: $progressEditSheetActivated) {
                            ProgressEditView(progressEditSheetActivated: $progressEditSheetActivated, book: book)
                        }.controlSize(.large)
                        Button(action: addBookToListButtonAction) {
                            Text("Add to list")
                        }.sheet(isPresented: $addBookToListSheetActivated) {
                            AddBookToCustomListView(book: book, dataModel: userListEntities.convertToToggleDataModel(), isBookListEditorActivated: $addBookToListSheetActivated)
                        }.controlSize(.large)
                        Button(action: loanBookButtonAction) {
                            if (book.loanedTo.isEmpty) {
                                Text("Loan book")
                            }
                            else {
                                Text("Return book")
                            }
                        }.sheet(isPresented: $bookLoanSheetActivated) {
                            LoanBookView(loanBookSheetActivated: $bookLoanSheetActivated, book: book)
                        }.controlSize(.large)
                    }.padding(.top)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }.padding()
            VStack(alignment: .leading) {
                HStack {
                    Text("My review and thoughts")
                        .font(.title)
                        .fontWeight(.bold)
                    Button(action: {
                        reviewEditSheetActivated = true
                    }) {
                        Image(systemName: "square.and.pencil").contentShape(Rectangle())
                    }.buttonStyle(.plain)
                        .sheet(isPresented: $reviewEditSheetActivated) {
                            ReviewEditView(book: book, review: book.review, isReviewEditActivated: $reviewEditSheetActivated)
                        }
                }
                ScrollView {
                    Text(book.review)
                }.frame(minHeight: 100)
            }.padding()
        }.padding().background(.background)
    }
    
    private func addBookToListButtonAction() {
        addBookToListSheetActivated = true
    }
    
    private func updateProgressButtonAction() {
        progressEditSheetActivated = true
    }
    
    private func loanBookButtonAction() {
        if (book.loanedTo.isEmpty) {
            bookLoanSheetActivated = true
        }
        else {
            book.loanedTo = ""
            saveBook()
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

struct ExploreBookView_Previews: PreviewProvider {
    
    static var previews: some View {
        ExploreBookView(book: BookEntity())
    }
}
