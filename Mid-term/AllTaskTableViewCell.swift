//
//  AllTaskTableViewCell.swift
//  Mid-term
//
//  Created by user252704 on 7/7/24.
//

import UIKit

class AllTaskTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ImageIcon: UIImageView!
    
    @IBOutlet weak var taskTitle: UILabel!
    
    @IBOutlet weak var DueTime: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var statusSwitch: UISwitch!
    
    var switchAction: (() -> Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()
//        statusSwitch.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    @objc func switchToggled() {
//        switchAction?()
//    }

}
