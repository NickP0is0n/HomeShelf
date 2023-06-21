//
//  LoanBookView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 14.06.2023.
//

import SwiftUI

struct LoanBookView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var loanBookSheetActivated: Bool
    @State private var loanPerson = ""
    let book: BookEntity
    
    var body: some View {
        VStack {
            Text("Loan this book")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
            Divider()
            HStack {
                TextField(text: $loanPerson) {
                    Text("Who do you loan this book to")
                }
            }.padding([.leading, .trailing, .top])
            HStack {
                Button(action: okButtonAction, label: {
                    Text("OK")
                }).keyboardShortcut(.defaultAction)
                Button(action: cancelButtonAction, label: {
                    Text("Cancel")
                }).keyboardShortcut(.cancelAction)
            }.padding()
        }.frame(minWidth: 200)
        
    }
    
    private func okButtonAction() {
        if (!loanPerson.isEmpty) {
            book.loanedTo = loanPerson
            do {
                try viewContext.save()
            } catch {
                viewContext.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            loanBookSheetActivated = false
        }
    }
    
    private func cancelButtonAction() {
        loanBookSheetActivated = false
    }
}

struct LoanBookView_Previews: PreviewProvider {
    static var previews: some View {
        LoanBookView(loanBookSheetActivated: .constant(true), book: BookEntity())
    }
}
