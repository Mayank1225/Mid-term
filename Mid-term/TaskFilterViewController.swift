import UIKit

class TaskFilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var sortAce: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }

    @IBAction func onClickSortAce(_ sender: Any) {
//        sortTasks(ascending: true)

    }
        func sortTasks(ascending: Bool) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd yyyy, h:mm a"
            
            data.sort { (task1, task2) -> Bool in
                if let date1 = dateFormatter.date(from: task1.dueTime),
                   let date2 = dateFormatter.date(from: task2.dueTime) {
                    return ascending ? date1 < date2 : date1 > date2
                }
                return false
            }
            table.reloadData()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "TaskCellfilter", for: indexPath) as! TaskFilterCellTableViewCell
        cell.task.text = row.title
        cell.iconimg.image = row.icon
        cell.duetime.text = "Due \(row.dueTime)"
        cell.taskStatus.text = row.status
        return cell
    }
}
