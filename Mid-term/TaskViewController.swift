//
//  TaskViewController.swift
//  Mid-term
//
//  Created by user252704 on 7/7/24.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var taskStatus: UILabel!
    
    @IBOutlet weak var taskImage: UIImageView!
    
    
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var taskTitle: UILabel!
    
    @IBOutlet weak var taskDue: UILabel!
    
    var image = UIImage()
    var satus = ""
    var titletask = ""
    var due = ""
    var taskDesc = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskStatus.text = satus
        taskDue.text = due
        taskTitle.text = titletask
        taskImage.image = image
        taskDescription.text = taskDesc
        // Do any additional setup after loading the view.
    }
}
