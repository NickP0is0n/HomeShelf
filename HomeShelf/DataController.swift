//
//  DataController.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 10.06.2023.
//

import Foundation
import CoreData

class DataController: NSObject, ObservableObject {
    /// Dynamic properties that the UI will react to
    @Published var bookEntities: [BookEntity] = [BookEntity]()
    
    /// Add the Core Data container with the model name
    let container: NSPersistentContainer = NSPersistentContainer(name: "LibraryDataModel")
    
    override init() {
            super.init()
            container.loadPersistentStores { _, _ in }
    }
}
