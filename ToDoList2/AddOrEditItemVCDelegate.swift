//
//  AddOrEditItemVCDelegate.swift
//  ToDoList2
//
//  Created by Sadie Flick on 5/16/18.
//  Copyright © 2018 Sadie Flick. All rights reserved.
//

import Foundation
import UIKit

protocol AddOrEditItemVCDelegate: class {
    func saveButtonPressed(from: UIViewController, with title: String?, and desc: String?, on date: Date?, sender indexPath: IndexPath?)
}
