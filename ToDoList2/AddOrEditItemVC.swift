//
//  AddOrEditItemVC.swift
//  ToDoList2
//
//  Created by Sadie Flick on 5/16/18.
//  Copyright © 2018 Sadie Flick. All rights reserved.
//

import UIKit

class AddOrEditItemVC: UIViewController {
    
    var delegate: ToDoVC?
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var indexPath: IndexPath?
    var task: Task?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if indexPath != nil {
            titleLabel.text = task?.taskTitle
            descLabel.text = task?.taskDetail
            datePicker.date = (task?.taskDate)!
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.saveButtonPressed(from: self, with: titleLabel.text, and: descLabel.text, on: datePicker.date, sender: indexPath)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
