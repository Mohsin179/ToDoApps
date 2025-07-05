//
//  RealmManager.swift
//  ToDoApp
//
//  Created by Syed Mohsin Hassan on 04/07/2025.
//

import Foundation
import RealmSwift

class RealmManager {
    
    public static let realm =  try! Realm.init(configuration: Realm.Configuration(schemaVersion: 2))
    
    public static let shared = RealmManager()
    
    private init() {}
    
    func createList(name: String, completion: @escaping (ListModel?,String?) -> Void ){
        let listModel = ListModel.init()
        listModel.id = UUID().uuidString
        listModel.name = name
        listModel.createdAt = "\(Date())"
        do {
            try RealmManager.realm.write {
                RealmManager.realm.add(listModel)
                completion(listModel,nil)
            }
        } catch (let error) {
            debugPrint(error)
            completion(nil,error.localizedDescription)
        }
    }
    
    func getLists() -> [ListModel] {
        var listModelArray = [ListModel]()
        let result = RealmManager.realm.objects(ListModel.self)
        for obj in result {
            listModelArray.append(obj)
        }
        return listModelArray
    }
    
    func addTask(listModel: ListModel, newDataModel: TaskModel) {
        //        let taskModel = TaskModel.init()
        //        taskModel.id = UUID().uuidString
        //        taskModel.title = title
        //        taskModel.details = details
        //        taskModel.isCompleted = false
        //        taskModel.createdAt = "\(Date())"
        do {
            try RealmManager.realm.write {
                listModel.tasks.append(newDataModel)
                RealmManager.realm.add(listModel, update: .modified)
            }
        } catch (let error) {
            debugPrint(error)
        }
    }
    func removeList(list: ListModel){
        do {
            let realm = try Realm()
            //            guard let object = realm.object(ofType: ListModel.self, forPrimaryKey: list?.id) else {
            //                print("No list found: \(list?.name ?? "")")
            //                return
            //            }
            try! realm.write {
                realm.delete(list)
            }
        } catch let error as NSError {
            // handle error
            print("error - \(error.localizedDescription)")
        }
    }
    func removetask(taskModel: TaskModel){
        do {
            let realm = try Realm()
            //            guard let object = realm.object(ofType: ListModel.self, forPrimaryKey: list?.id) else {
            //                print("No list found: \(list?.name ?? "")")
            //                return
            //            }
            try! realm.write {
                realm.delete(taskModel)
            }
        } catch let error as NSError {
            // handle error
            print("error - \(error.localizedDescription)")
        }
    }
    
    func editList(listModel: ListModel, taskModel: TaskModel) {
        do {
            let realm = try Realm()
            //            guard let object = realm.object(ofType: ListModel.self, forPrimaryKey: list?.id) else {
            //                print("No list found: \(list?.name ?? "")")
            //                return
            //            }
            try! realm.write {
                listModel.tasks.append(taskModel)
                RealmManager.realm.add(listModel, update: .all)
            }
        } catch let error as NSError {
            // handle error
            print("error - \(error.localizedDescription)")
        }
    }
}

