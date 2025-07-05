//
//  ListViewController.swift
//  ToDoApp
//
//  Created by Syed Mohsin Hassan on 04/07/2025.
//
protocol ShowNewListDelegate{
    func showNewListModel(listModel: ListModel)
}

import UIKit
import GrowingTextView

class ListViewController: UIViewController {
    
    
    var delegate: ShowNewListDelegate?
    var selectedModel: ListModel?
    
    @IBOutlet weak var titletextView: GrowingTextView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titletextView.text = selectedModel?.name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titletextView.becomeFirstResponder()
    }
    
    
    @IBAction func dimissButton(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        RealmManager.shared.createList(name: titletextView.text) { (listModel,error) in
            guard let listModel = listModel else {
                return
            }
            NotificationCenter.default.post(name: .createNewList, object: listModel)
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//    }
    
}
extension ListViewController: GrowingTextViewDelegate {
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    
}
