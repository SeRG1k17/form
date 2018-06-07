//
//  CustomTableViewCell.swift
//  Form
//
//  Created by Sergey Pugach on 07.06.2018.
//  Copyright © 2018 Сергей Пугач. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    
    var update: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        textfield.addTarget(self, action: #selector(changed(_:)), for: .editingChanged)
    }

    @objc func changed(_ sender: UITextField) {
        update?()
    }
}
