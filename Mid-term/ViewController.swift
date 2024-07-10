import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
//        self.navigationController?.navigationBar.isHidden = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDodata.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = ToDodata[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! AllTaskTableViewCell
        cell.taskTitle.text = row.title
        cell.ImageIcon.image = row.icon
        cell.DueTime.text = "Due \(row.dueTime)"
        cell.status.text = row.status
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "TaskViewController") as? TaskViewController {
            vc.satus = "Task \(ToDodata[indexPath.row].status)"
            vc.due = "Due at: \(ToDodata[indexPath.row].dueTime)"
            vc.titletask = "Task: \(ToDodata[indexPath.row].title)"
            vc.image = ToDodata[indexPath.row].icon
            vc.taskDesc = ToDodata[indexPath.row].description
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            ToDodata.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
