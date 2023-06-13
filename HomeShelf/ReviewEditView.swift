//
//  ReviewEditView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 13.06.2023.
//

import SwiftUI

struct ReviewEditView: View {
    @EnvironmentObject var manager: DataController
    @Environment(\.managedObjectContext) private var viewContext
    let book: BookEntity
    @State private var review: String = ""
    @Binding var isReviewEditActivated: Bool
    
    var body: some View {
        VStack {
            Text("Review and thoughts on this book")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
            Divider()
            TextEditor(text: $review)
                .padding()
            HStack {
                Button(action: okButtonAction) {
                    Text("OK")
                }
                Button(action: cancelButtonAction) {
                    Text("Cancel")
                }
            }.padding()
        }
    }
    
    private func okButtonAction() {
        isReviewEditActivated = false
        book.review = review
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    private func cancelButtonAction() {
        isReviewEditActivated = false
    }
}

struct ReviewEditView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewEditView(book: BookEntity(), isReviewEditActivated: .constant(true))
    }
}
