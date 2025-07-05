//
//  ListTableView.swift
//  ToDoApp
//
//  Created by Syed Mohsin Hassan on 04/07/2025.
//

import Foundation
import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lableName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(listName: String){
        lableName.text = listName
    }
}
