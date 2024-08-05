//
//  ToDoCell.swift
//  ToDoList_Safir
//
//  Created by Kazi safir on 3/9/24.
//  Copyright © 2024 Kazi Safir. All rights reserved.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    
    @IBOutlet var isCompleteButton: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    
    
    weak var delegate: ToDoCellDelegate?
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.checkmarkTapped(sender: self)
    }
    
    
    
}
