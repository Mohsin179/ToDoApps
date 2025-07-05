//
//  CalenderViewController.swift
//  ToDoApp
//
//  Created by Syed Mohsin Hassan on 04/07/2025.
//

import UIKit

protocol CalenderViewControllerDelegate: NSObjectProtocol {
    func datePicker(_ controller: CalenderViewController, didSelect date: Date)
}

class CalenderViewController: UIViewController {

    @IBOutlet weak var calenderView: UIView!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    public var mode: UIDatePicker.Mode = .dateAndTime
    public var minimumDate: Date = Date()
    public var maximumDate: Date?
    public var isCustomized: Bool = false
    weak var delegate: CalenderViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareDatePicker()
        Utilities.styleView(calenderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.transition(with: self.view, duration: .zero, options: [.transitionCrossDissolve]) {
            self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.6
            )
        }
    }
    

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneButton(_ sender: Any) {
        delegate?.datePicker(self, didSelect:datePicker.date)
        dismiss(animated: true)
    }
}

// MARK: - Prepare datepicker
private extension CalenderViewController {
    func prepareDatePicker() {
        datePicker.datePickerMode = mode
        datePicker.tintColor = UIColor.init(named: "labelColor")
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = mode == .time ? .wheels : .inline
        } else {
//             Fallback on earlier versions
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.maximumDate = maximumDate
        datePicker.minimumDate = minimumDate
    }
}
