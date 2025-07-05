//
//  TaskModel.swift
//  ToDoApp
//
//  Created by Syed Mohsin Hassan on 04/07/2025.
//

import Foundation
import RealmSwift

class TaskModel: Object {
    @objc dynamic var id: String?
    @objc dynamic var title = ""
    @objc dynamic var details = ""
    @objc dynamic var isCompleted = false
    @objc dynamic var createdAt = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

