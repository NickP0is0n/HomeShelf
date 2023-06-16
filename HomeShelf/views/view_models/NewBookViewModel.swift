//
//  NewBookViewModel.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 16.06.2023.
//

import Foundation

class NewBookViewModel: ObservableObject {
    @Published var title = ""
    @Published var author: String = ""
    @Published var pageCount: String = ""
    @Published var storeLink: String = ""
    @Published var coverPictureFilename: String = ""
    
    func isTitleEmpty() -> Bool {
        if (title.isEmpty) {
            return true
        }
        return false
    }
    
    func isAuthorEmpty() -> Bool {
        if (author.isEmpty) {
            return true
        }
        return false
    }
    
    func isPageCountEmpty() -> Bool {
        if (pageCount.isEmpty) {
            return true
        }
        return false
    }
    
    func isPageCountValid() -> Bool {
        let pageCountTest = NSPredicate(format: "SELF MATCHES %@", "^[1-9][0-9]*$") // Only matches numbers
        return pageCountTest.evaluate(with: pageCount)
    }
    
    func isCoverPictureEmpty() -> Bool {
        if (coverPictureFilename.isEmpty) {
            return true
        }
        return false
    }
    
    func isCoverPictureValid() -> Bool {
        let coverPictureTest = NSPredicate(format: "SELF MATCHES %@", "^\\/(?:[^\\/\0]+\\/)*[^\\/\0]+\\.(?:png|jpe?g|bmp|tiff?)$") // Only matches numbers
        return coverPictureTest.evaluate(with: coverPictureFilename)
    }
    
    func isModelValid() -> Bool {
        if (isTitleEmpty() ||
            isAuthorEmpty() ||
            isPageCountEmpty() || !isPageCountValid() ||
            isCoverPictureEmpty() || !isCoverPictureValid()) {
            return false
        }
        return true
    }
    
    var titleErrorPrompt: String {
        if (self.isTitleEmpty()) {
            return "Please enter the title of the book."
        }
        return ""
    }
    
    var authorErrorPrompt: String {
        if (self.isAuthorEmpty()) {
            return "Please specify the author of the book."
        }
        return ""
    }
    
    var pageCountErrorPrompt: String {
        if (self.isPageCountEmpty()) {
            return "Please specify the page count of the book."
        }
        else if (!self.isPageCountValid()) {
            return "Page count must only contain a number."
        }
        return ""
    }
    
    var coverPictureErrorPrompt: String {
        if (self.isCoverPictureEmpty()) {
            return "Please select the cover image of the book."
        }
        else if (!self.isCoverPictureValid()) {
            return "Selected file is not a supported format image."
        }
        return ""
    }
}
