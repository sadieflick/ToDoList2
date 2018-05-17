//
//  TDCell.swift
//  ToDoList2
//
//  Created by Sadie Flick on 5/16/18.
//  Copyright © 2018 Sadie Flick. All rights reserved.
//

import UIKit

class TDCell: UITableViewCell {
    
    @IBOutlet weak var titleDisplay: UILabel!
    @IBOutlet weak var dateDisplay: UILabel!
    @IBOutlet weak var descDisplay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
