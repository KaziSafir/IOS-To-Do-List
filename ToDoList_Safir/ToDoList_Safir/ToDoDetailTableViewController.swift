//
//  ToDoDetailTableViewController.swift
//  ToDoList_Safir
//
//  Created by Kazi safir on 3/8/24.
//  Copyright © 2024 Kazi Safir. All rights reserved.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {
    
    var toDo: ToDo?
    
    var isDatePickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)
    
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDateDatePicker: UIDatePicker!
    @IBOutlet var notesTextView: UITextView!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDueDate: Date
        if let toDo = toDo {
          navigationItem.title = "To-Do"
          titleTextField.text = toDo.title
          isCompleteButton.isSelected = toDo.isComplete
          currentDueDate = toDo.dueDate
          notesTextView.text = toDo.notes
        } else {
          currentDueDate = Date().addingTimeInterval(24*60*60)
        }

        dueDateDatePicker.date = currentDueDate
        updateDueDateLabel(date: currentDueDate)
        updateSaveButtonState()
    }

    
    func updateDueDateLabel(date: Date){
        dueDateLabel.text = date.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
    }
    

    func updateSaveButtonState() {
        let shouldEnableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnableSaveButton
    }

    override func tableView(_ tableView: UITableView,
       heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath where isDatePickerHidden == true:
            return 0
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return 216
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == dateLabelIndexPath {
            isDatePickerHidden.toggle()
            updateDueDateLabel(date: dueDateDatePicker.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }


    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard segue.identifier == "saveUnwind" else { return }

        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDateDatePicker.date
        let notes = notesTextView.text
        
                
        if toDo != nil {
                toDo?.title = title
                toDo?.isComplete = isComplete
                toDo?.dueDate = dueDate
                toDo?.notes = notes
            } else {
                toDo = ToDo(title: title, isComplete: isComplete,
                   dueDate: dueDate, notes: notes)
            }
        
    }
    
    
}
