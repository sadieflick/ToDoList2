//
//  ViewController.swift
//  ToDoList2
//
//  Created by Sadie Flick on 5/16/18.
//  Copyright © 2018 Sadie Flick. All rights reserved.
//

import UIKit
import CoreData

class ToDoVC: UIViewController, AddOrEditItemVCDelegate {
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableData: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchAllItems()

        tableView.rowHeight = 120
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("In prepare")
        let navController = segue.destination as! UINavigationController
        let addOrEditItemVC = navController.topViewController as! AddOrEditItemVC
        addOrEditItemVC.delegate = self
        
        if let ip = sender as? IndexPath {
            addOrEditItemVC.indexPath = ip
            addOrEditItemVC.task = tableData[ip.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "mainSegue", sender: sender)
    }

    
    func saveButtonPressed(from: UIViewController, with title: String?, and desc: String?, on date: Date?, sender indexPath: IndexPath?) {
        
        if let ip = indexPath {
            tableData[ip.row].taskTitle = title
            tableData[ip.row].taskDetail = desc
            tableData[ip.row].taskDate = date
            tableView.reloadData()
        }
        
        else if indexPath == nil {
            let newTask = Task(context: context)
            newTask.checked = false
            newTask.taskTitle = title
            newTask.taskDetail = desc
            newTask.taskDate = date
            
            tableData.append(newTask)
            tableView.reloadData()
        }
        
        saveContext()

        
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, nil) in
            self.performSegue(withIdentifier: "mainSegue", sender: indexPath)
        }
        
        edit.backgroundColor = UIColor.blue
        
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            print("Delete")
            
            
            // Remove from core data/ context
            let task = self.tableData[indexPath.row]
            self.context.delete(task)
            
            // Remove from table data
            self.tableData.remove(at: indexPath.row)
            
            self.saveContext()
            
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                tableData[indexPath.row].checked = true
            }
            
            else if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                tableData[indexPath.row].checked = false
            }
            saveContext()
        }
    }

    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//        // Remove from table data
//        tableData.remove(at: indexPath.row)
//
//        // Remove from core data/ context
//        let task = tableData[indexPath.row]
//        context.delete(task)
//
//        saveContext()
//
//        tableView.deleteRows(at: [indexPath], with: .bottom)
//    }
    
    func fetchAllItems() {
        let request:NSFetchRequest<Task> = Task.fetchRequest()
        do {
            tableData = try context.fetch(request)
            // Here we can store the fetched data in an array
        } catch {
            
        }
    }

}

extension ToDoVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("Table data: ", tableData)
        
        // Get Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TDCell", for: indexPath) as! TDCell
        
        // Set display items in cell
        cell.titleDisplay.text = tableData[indexPath.row].taskTitle
        cell.descDisplay.text = tableData[indexPath.row].taskDetail
        
        //Display checkmarks
        if tableData[indexPath.row].checked == true {
            cell.accessoryType = .checkmark
        }
        
        
        // Convert date
        let date = tableData[indexPath.row].taskDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let dateText = dateFormatter.string(from: (date)!)
//        self.view.endEditing(true)
        
        // Set date
        cell.dateDisplay.text = dateText
        
        
        return cell
    }
    
}

