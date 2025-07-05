//
//  HomeViewModel.swift
//  ToDoApp
//
//  Created by Mohsin Hassan on 05/07/2025.
//

import UIKit

protocol HomeViewModelDelegate: NSObjectProtocol {
    func getlistSuccessfully(from: HomeViewModel, listModel: ListModel)
}
class HomeViewModel: ViewModelType {

    weak var controller: UIViewController?
    weak var delegate: HomeViewModelDelegate?
    
    init(controller: UIViewController) {
        self.controller = controller
        delegate = controller as? HomeViewModelDelegate
        bootstrap()
    }

    func bootstrap() {
        getData()
    }
    
    func getData() {
        let listdata = RealmManager.shared.getLists().first
        guard let listModel = listdata else { return }
        delegate?.getlistSuccessfully(from: self, listModel: listModel)
    }
}
