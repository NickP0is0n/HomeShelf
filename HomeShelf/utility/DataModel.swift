//
//  DataModel.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 14.06.2023.
//

import SwiftUI

class DataModel: ObservableObject {
    @Published var toggles: [ToggleModel]
    
    init(toggles: [ToggleModel]) {
        self.toggles = toggles
    }
}

struct ToggleModel: Hashable {
    init(id: Int, title: String, isActive: Bool) {
        self.id = id
        self.title = title
        self.isActive = isActive
    }

    let id: Int
    let title: String
    var isActive: Bool
}

extension FetchedResults<UserListEntity> {
    func convertToToggleDataModel() -> DataModel {
        let dataModel = DataModel(toggles: [])
        var currentId = 1
        self.forEach { userListEntity in
            dataModel.toggles.append(ToggleModel(id: currentId, title: userListEntity.listName, isActive: false))
            currentId += 1
        }
        return dataModel
    }
}
