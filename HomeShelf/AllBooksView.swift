//
//  AllBooksView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 08.06.2023.
//

import SwiftUI

struct AllBooksView: View {
    var body: some View {
        ScrollView {
        }.navigationTitle("All books")
        .toolbar {
            ToolbarItem(placement: .navigation){
                Button(action: addBook, label: {
                    Image(systemName: "plus.app")
                })
            }
        }
    }
}

func addBook() {
    
}

struct AllBooksView_Previews: PreviewProvider {
    static var previews: some View {
        AllBooksView()
    }
}
