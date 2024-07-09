

import UIKit

struct Todo {
    var icon: UIImage
    var title: String
    var dueTime: String
    var status: String
    var description: String
}

var data: [Todo] = [
    Todo(icon: UIImage(systemName: "fork.knife")!, title: "Wash dishes", dueTime: "July 07 2024, 3:09 PM", status: "Pending", description: "Clean all the dirty dishes."),
    Todo(icon: UIImage(systemName: "leaf")!, title: "Water plants", dueTime: "July 07 2024, 6:00 AM", status: "Completed", description: "Water all the indoor and outdoor plants."),
    Todo(icon: UIImage(systemName: "cart")!, title: "Buy milk", dueTime: "July 07 2024, 9:00 AM", status: "Pending", description: "Get fresh milk from the grocery store."),
    Todo(icon: UIImage(systemName: "briefcase")!, title: "Finish report", dueTime: "July 07 2024, 1:00 PM", status: "Pending", description: "Complete the financial report for Q2."),
    Todo(icon: UIImage(systemName: "figure.walk")!, title: "Morning run", dueTime: "July 07 2024, 6:00 AM", status: "Completed", description: "Go for a 5km run in the park."),
    Todo(icon: UIImage(systemName: "book")!, title: "Read novel", dueTime: "July 07 2024, 8:00 PM", status: "Pending", description: "Read 'To Kill a Mockingbird' before bed."),
    Todo(icon: UIImage(systemName: "hammer")!, title: "Fix the door", dueTime: "July 07 2024, 4:00 PM", status: "Pending", description: "Repair the broken door handle in the kitchen."),
    Todo(icon: UIImage(systemName: "phone")!, title: "Call mom", dueTime: "July 07 2024, 6:00 PM", status: "Pending", description: "Catch up with mom over a phone call.")
]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! AllTaskTableViewCell
        cell.taskTitle.text = row.title
        cell.ImageIcon.image = row.icon
        cell.DueTime.text = "Due \(row.dueTime)"
        cell.status.text = row.status
//        cell.statusSwitch.setOn(row.status == "Completed", animated: true)
//        cell.switchAction = { [weak self] in
//            self?.toggleTaskStatus(at: indexPath)
//        }
        
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "TaskViewController") as? TaskViewController {
            vc.satus = "Task \(data[indexPath.row].status)"
            vc.due = "Due at: \(data[indexPath.row].dueTime)"
            vc.titletask = "Task: \(data[indexPath.row].title)"
            vc.image = data[indexPath.row].icon
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }

//    func toggleTaskStatus(at indexPath: IndexPath) {
//        if data[indexPath.row].status == "Pending" {
//            presentCompletionAlert(for: indexPath)
//        } else {
//            showToast(message: "\(data[indexPath.row].title) is already completed")
//            table.reloadRows(at: [indexPath], with: .automatic)
//        }
//    }
//
//    func presentCompletionAlert(for indexPath: IndexPath) {
//        let alert = UIAlertController(title: "Complete Task", message: "Are you sure the task is completed?", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
//            self.table.reloadRows(at: [indexPath], with: .automatic) // To reset the switch state
//        }))
//        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
//            data[indexPath.row].status = "Completed"
//            self.table.reloadRows(at: [indexPath], with: .automatic)
//        }))
//        present(alert, animated: true, completion: nil)
//    }
//
//    func showToast(message: String) {
//        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-100, width: 300, height: 35))
//        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        toastLabel.textColor = UIColor.white
//        toastLabel.textAlignment = .center
//        toastLabel.text = message
//        toastLabel.alpha = 1.0
//        toastLabel.layer.cornerRadius = 10
//        toastLabel.clipsToBounds = true
//        self.view.addSubview(toastLabel)
//        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
//            toastLabel.alpha = 0.0
//        }, completion: { (isCompleted) in
//            toastLabel.removeFromSuperview()
//        })
//    }
}
