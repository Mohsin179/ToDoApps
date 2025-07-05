//
//  MoreViewController.swift
//  ToDoApp
//
//  Created by Syed Mohsin Hassan on 04/07/2025.
//

import UIKit
import CoreData

protocol MoreViewControllerDelegate: NSObjectProtocol {
    func listDeleted(_ controller: MoreViewController)
    func EditList(_ controller: MoreViewController)
}

class MoreViewController: UIViewController{
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var selectedModel: ListModel?
    var taskModelArray: [TaskModel] = []
    weak var delegate: MoreViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        
        Utilities.deleteStyleButton(deleteButton)
    }
    deinit {
        removeObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.transition(with: self.view, duration: .zero, options: [.transitionCrossDissolve]) {
            self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.8
            )
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func deleteList(_ sender: Any) {
        guard let list = selectedModel else { return }
         RealmManager.shared.removeList(list: list)
        self.dismiss(animated: true, completion: nil)
        delegate?.listDeleted(self)
    }
    
    @IBAction func didTapEdit(_ sender: Any) {
        if let presenter = self.presentingViewController,
           let storyboard = self.storyboard {
            presenter.dismiss(animated: true) {
                guard self.selectedModel?.tasks.count != 0 else {
                    self.editButton.isEnabled = false
                    return
                }
                let targetVC = storyboard.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
                targetVC.selectedModel = self.selectedModel
                targetVC.modalTransitionStyle = .coverVertical
                targetVC.modalPresentationStyle = .fullScreen
                presenter.present(targetVC, animated: true, completion: nil)
            }
        }
    }
    
    
    
}
//MARK: - Notifications
extension MoreViewController {
    
    private func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(createNewList(_:)), name: .createNewList, object: nil)
    }
    
    private func removeObservers(){
        NotificationCenter.default.removeObserver(self, name: .createNewList, object: nil)
    }
    
    @objc func createNewList(_ notification: NSNotification){
        guard let listModel = notification.object as? ListModel else {
            return
        }
        selectedModel = listModel
        print(listModel)
    }
}
