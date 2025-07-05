//
//  MenuViewController.swift
//  ToDoApp
//
//  Created by Syed Mohsin Hassan on 04/07/2025.
//

import UIKit
protocol CanReceiveDelegate{
    func showListModel(listModel: ListModel)
}


class MenuViewController: UIViewController{
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    var listModelArray = [ListModel]()
    var delegate: CanReceiveDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.transition(with: self.view, duration: .zero, options: [.transitionCrossDissolve]) {
            self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.8
            )
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
        UIView.transition(with: self.view, duration: .zero, options: [.transitionCrossDissolve]) {
            self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.8
            )
        }
    }

    @IBAction func createListButton(_ sender: Any) {
        let svc = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        
        svc.modalTransitionStyle = .coverVertical
        svc.modalPresentationStyle = .fullScreen
        self.present(svc, animated: true, completion:nil)
    }
    
    @IBAction func feedbackButton(_ sender: Any) {
    }
    
    
    @IBAction func licensesButton(_ sender: Any) {
    }
    
    
    @IBAction func listButton(_ sender: Any) {
        
    }
    
}

extension MenuViewController{
    
    private func prepareView(){
        Utilities.buttonstyleView(view1)
        Utilities.buttonstyleView(view2)
        Utilities.buttonstyleView(view3)
        Utilities.buttonstyleView(view4)
    }
    
    func loadData(){
        listModelArray = RealmManager.shared.getLists()
        listTableView.reloadData()
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ListTableViewCell", for: indexPath) as! ListTableViewCell
        let listModel = listModelArray[indexPath.row]
        cell.configureCell(listName: listModel.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listModel = listModelArray[indexPath.row]
        delegate?.showListModel(listModel: listModel)
        self.dismiss(animated: true, completion: nil)
    }
    
}
