//
//  ToDoTableViewController.swift
//  ToDoList_Safir
//
//  Created by Kazi safir on 3/8/24.
//  Copyright © 2024 Kazi Safir. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    
    var toDos = [ToDo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //This line adds an edit button
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedToDos = ToDo.loadToDos(){
            toDos = savedToDos
        } else {
            toDos = ToDo.loadSampleToDos()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ToDoCellIdentifier", for: indexPath) as! ToDoCell
        
        
    let toDo = toDos[indexPath.row]
        cell.titleLabel?.text = toDo.title
        cell.isCompleteButton.isSelected = toDo.isComplete
        cell.delegate = self
    return cell
    }
    //Function that used to edit row
    override func tableView(_ tableView: UITableView, canEditRowAt
       indexPath: IndexPath) -> Bool {
        return true
    }
    //function that lets the delete buttion deletes the row/array from the table
    override func tableView(_ tableView: UITableView, commit
       editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:
       IndexPath) {
        if editingStyle == .delete {
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(toDos)
        }
    }
   
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as!
           ToDoDetailTableViewController

        if let toDo = sourceViewController.toDo {
            if let indexOfExistingToDo = toDos.firstIndex(of: toDo){
                toDos[indexOfExistingToDo] = toDo
                tableView.reloadRows(at: [IndexPath(row: indexOfExistingToDo, section: 0)], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: toDos.count, section: 0)
                toDos.append(toDo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        ToDo.saveToDos(toDos)
    }
    
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
        let detailController = ToDoDetailTableViewController(coder: coder)
        
        guard let cell = sender as? UITableViewCell,let indexPath = tableView.indexPath(for: cell) else {
            return detailController
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        detailController?.toDo = toDos[indexPath.row]
        
        return detailController
    }
    
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var toDo = toDos[indexPath.row]
            toDo.isComplete.toggle()
            toDos[indexPath.row] = toDo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(toDos)
        }
    }
    
}
