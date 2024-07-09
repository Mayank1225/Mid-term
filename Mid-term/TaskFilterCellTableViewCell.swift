//
//  TaskFilterCellTableViewCell.swift
//  Mid-term
//
//  Created by user252704 on 7/7/24.
//

import UIKit

class TaskFilterCellTableViewCell: UITableViewCell {

        
    @IBOutlet weak var iconimg: UIImageView!
    @IBOutlet weak var duetime: UILabel!
    @IBOutlet weak var taskStatus: UILabel!
    @IBOutlet weak var task: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
