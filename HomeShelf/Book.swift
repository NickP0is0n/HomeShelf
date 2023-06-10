//
//  Book.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 10.06.2023.
//

import Foundation
import AppKit

class Book {
    let title: String
    let author: String
    let pageCount: Int
    let storeLink: String
    var cover: NSImage
    var rating: Int
    var review: String
    
    init(title: String, author: String, cover: NSImage, pageCount: Int, storeLink: String) {
        self.title = title
        self.author = author
        self.cover = cover
        self.pageCount = pageCount
        self.storeLink = storeLink
        self.rating = 0
        self.review = ""
    }
}
