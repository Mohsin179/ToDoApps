//
//  TaskTableView.swift
//  ToDoApp
//
//  Created by Syed Mohsin Hassan on 04/07/2025.
//
import UIKit
import Foundation
import GrowingTextView

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDetailTextView: GrowingTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(tasktitle: String,taskdetail: String){
        taskTitle.text = tasktitle
        taskDetailTextView.text = taskdetail
    }

}
