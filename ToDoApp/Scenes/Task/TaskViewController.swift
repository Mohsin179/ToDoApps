//
//  TaskViewController.swift
//  ToDoApp
//
//  Created by Syed Mohsin Hassan on 04/07/2025.
//

import UIKit
import GrowingTextView

protocol ShowNewDataDelegate{
    func showNewTaskModel(listModel: ListModel)
}


class TaskViewController: UIViewController{
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var stackViewfield: UIStackView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var taskTitletextView: GrowingTextView!
    @IBOutlet weak var taskDetailTextView: GrowingTextView!
    
    var delegate: ShowNewDataDelegate?
    var selectedModel: ListModel?
    var taskModelArray: [TaskModel] = []
    var selectedTask: TaskModel?
    var isEdit: Bool = false
    public var selectedDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        taskTitletextView.delegate = self
        taskDetailTextView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.transition(with: self.view, duration: .zero, options: [.transitionCrossDissolve]) {
            self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.5
            )
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    func prepareView() {
        guard isEdit else { return }
        prepareData()
    }
    
    
    @IBAction func showDetailButton(_ sender: Any) {
        taskDetailTextView.isHidden = false
    }
    
    @IBAction func calenderButton(_ sender: Any) {
        let svc = storyboard?.instantiateViewController(withIdentifier: "CalenderViewController") as! CalenderViewController
        svc.modalTransitionStyle = .crossDissolve
        svc.modalPresentationStyle = .overFullScreen
        svc.delegate = self
        present(svc, animated: true, completion:nil)
    }
    
    
    @IBAction func saveTaskButton(_ sender: Any) {
        guard !isEdit else {
            editTaskandNavigate()
           return
        }
        createTaskandNavigate()
    }
}

extension TaskViewController {
    func prepareData(){
        taskTitletextView.text = selectedTask?.title ?? ""
        taskDetailTextView.text = selectedTask?.details ?? ""
    }
}

extension TaskViewController: GrowingTextViewDelegate {
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}

extension TaskViewController: CalenderViewControllerDelegate {
    func datePicker(_ controller: CalenderViewController, didSelect date: Date) {
        self.selectedDate = date
    }
}
extension TaskViewController{
    func createTaskandNavigate() {
        let newModel = createTaskModel(title: taskTitletextView.text, details: taskDetailTextView.text)
        guard let selectedModel = selectedModel else {
            return
        }
        print(selectedModel)
        RealmManager.shared.addTask(listModel: selectedModel, newDataModel: newModel)
        delegate?.showNewTaskModel(listModel: selectedModel)
        self.dismiss(animated: true, completion: nil)
    }
    
    func editTaskandNavigate() {
        let newModel = createTaskModel(title: taskTitletextView.text, details: taskDetailTextView.text)
        guard let selectedModel = selectedModel else {
            return
        }
        RealmManager.shared.editList(listModel: selectedModel, taskModel: newModel)
        delegate?.showNewTaskModel(listModel: selectedModel)
        self.dismiss(animated: true, completion: nil)
    }
    
    func createTaskModel(title: String, details: String) -> TaskModel {
        let taskModel = TaskModel.init()
        taskModel.id = UUID().uuidString
        taskModel.title = title
        taskModel.details = details
        taskModel.isCompleted = false
        let formattedDate = selectedDate.string(withFormat: "dd/MM/yyyy")
        taskModel.createdAt = "\(formattedDate)"
        return taskModel
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                
                
                let newHeight = self.view.frame.height -  (stackView.frame.height + stackViewfield.frame.height + view1.frame.height + keyboardSize.height)
                taskDetailTextView.maxHeight = newHeight
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

