//
//  BookRatingView.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 12.06.2023.
//

import SwiftUI

struct BookRatingView: View {
    let bookRating: Int
    var body: some View {
        HStack {
            ForEach(1..<6) { i in
                if (i <= bookRating) {
                    Image(systemName: "star.fill")
                }
                else {
                    Image(systemName: "star")
                }
            }
        }
    }
}

struct BookRatingView_Previews: PreviewProvider {
    static var previews: some View {
        BookRatingView(bookRating: 2)
    }
}
