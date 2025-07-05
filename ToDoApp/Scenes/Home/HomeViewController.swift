//
//  HomeViewController.swift
//  ToDoApp
//
//  Created by Syed Mohsin Hassan on 04/07/2025.
//

import UIKit


class HomeViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var listTitleLabel: UILabel!
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var bottomview: UIView!
    
    var taskModelArray: [TaskModel] = []
    var selectedModel: ListModel?
    var viewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewModel()
        addObservers()
        prepareView()
        taskTableView.reloadData()
    }
    deinit {
        removeObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        prepareView()
        taskTableView.reloadData()
    }
    
    @IBAction func menuButton(_ sender: Any) {
        MenuView()
    }
    
    @IBAction func taskButton(_ sender: Any) {
        taskView()
    }
    
    
    @IBAction func moreButton(_ sender: Any) {
        guard let list = selectedModel else { return }
        listTitleLabel.text = ""
        RealmManager.shared.removeList(list: list)
        MenuView()
    }
}
extension HomeViewController {
    private func prepareView(){
        prepareDelegates()
        prepareCustomViews()
    }
    
    func prepareDelegates() {
        taskTableView.delegate = self
        taskTableView.dataSource = self
    }
    
    func prepareCustomViews() {
        Utilities.styleView(bottomview)
        Utilities.StyleButton(taskButton)
    }
}

// MARK: - HomeViewModel
extension HomeViewController {
    func prepareViewModel() {
        self.viewModel = HomeViewModel.init(controller: self)
    }
}


// MARK: - UITableViewDelegate and UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  taskModelArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        let taskModel = taskModelArray[indexPath.row]
        cell.configureCell(tasktitle: taskModel.title, taskdetail: taskModel.details)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let taskModel = taskModelArray[indexPath.row]
            RealmManager.shared.removetask(taskModel: taskModel)
            taskModelArray.remove(at: indexPath.row)
            self.taskTableView.beginUpdates()
            self.taskTableView.deleteRows(at: [indexPath], with: .fade)
            self.taskTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskModel = taskModelArray[indexPath.row]
        EdittaskView(task: taskModel)
    }
}
// MARK: - Helper Function
extension HomeViewController{
    private func MenuView(){
        let svc = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        svc.delegate = self
        
        svc.modalTransitionStyle = .coverVertical
        svc.modalPresentationStyle = .overCurrentContext
        present(svc, animated: true, completion:nil)
    }
    
    private func taskView(){
        let svc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        svc.delegate = self
        svc.selectedModel = selectedModel
        svc.modalTransitionStyle = .coverVertical
        svc.modalPresentationStyle = .overCurrentContext
        present(svc, animated: true, completion:nil)
    }
    
    private func EdittaskView(task: TaskModel){
        let svc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        svc.delegate = self
        svc.isEdit = true
        svc.selectedTask = task
        svc.selectedModel = selectedModel
        svc.modalTransitionStyle = .coverVertical
        svc.modalPresentationStyle = .overCurrentContext
        present(svc, animated: true, completion:nil)
    }
}

//MARK: - Notifications
extension HomeViewController {
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
        listTitleLabel.text = listModel.name
        taskModelArray.removeAll()
        taskTableView.reloadData()
    }
}

extension HomeViewController: ShowNewDataDelegate{
    func showNewTaskModel(listModel: ListModel) {
        print(listModel)
        taskModelArray.removeAll()
        taskModelArray.append(contentsOf: listModel.tasks)
        taskTableView.reloadData()
    }
}
extension HomeViewController: CanReceiveDelegate{
    func showListModel(listModel: ListModel) {
        self.selectedModel = listModel
        listTitleLabel.text?.removeAll()
        listTitleLabel.text = listModel.name
        taskModelArray.removeAll()
        taskModelArray.append(contentsOf: listModel.tasks)
        taskTableView.reloadData()
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func getlistSuccessfully(from: HomeViewModel, listModel: ListModel) {
        self.selectedModel = listModel
        listTitleLabel.text?.removeAll()
        listTitleLabel.text = listModel.name
        taskModelArray.removeAll()
        taskModelArray.append(contentsOf: listModel.tasks)
        taskTableView.reloadData()
    }
}
