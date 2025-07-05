//
//  ListModel.swift
//  ToDoApp
//
//  Created by Syed Mohsin Hassan on 04/07/2025.
//

import Foundation
import RealmSwift

class ListModel: Object {
    @objc dynamic var id: String?
    @objc dynamic var name = ""
    @objc dynamic var createdAt = ""
    
    let tasks = List<TaskModel>()
    override class func primaryKey() -> String? {
        return "id"
    }
}


