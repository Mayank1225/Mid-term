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
    Todo(icon: UIImage(systemName: "leaf")!, title: "Water plants", dueTime: "July 08 2024, 6:00 AM", status: "Completed", description: "Water all the indoor and outdoor plants."),
    Todo(icon: UIImage(systemName: "cart")!, title: "Buy milk", dueTime: "July 10 2024, 9:00 AM", status: "Pending", description: "Get fresh milk from the grocery store."),
    Todo(icon: UIImage(systemName: "briefcase")!, title: "Finish report", dueTime: "July 04 2024, 1:00 PM", status: "Pending", description: "Complete the financial report for Q2."),
    Todo(icon: UIImage(systemName: "figure.walk")!, title: "Morning run", dueTime: "June 07 2024, 6:00 AM", status: "Completed", description: "Go for a 5km run in the park."),
    Todo(icon: UIImage(systemName: "book")!, title: "Read novel", dueTime: "July 01 2024, 8:00 PM", status: "Pending", description: "Read 'To Kill a Mockingbird' before bed."),
    Todo(icon: UIImage(systemName: "hammer")!, title: "Fix the door", dueTime: "July 05 2024, 4:00 PM", status: "Completed", description: "Repair the broken door handle in the kitchen."),
    Todo(icon: UIImage(systemName: "phone")!, title: "Call mom", dueTime: "July 07 2024, 6:00 PM", status: "Pending", description: "Catch up with mom over a phone call.")
]
var ToDodata: [Todo] = data

class TaskFilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var switchForTask: UISwitch!
    @IBOutlet weak var filterSegment: UISegmentedControl!
    
    @IBOutlet weak var asceSwitch: UISwitch!
    
    @IBOutlet weak var descSwitch: UISwitch!
    
    var filteredData: [Todo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        updateFilteredData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ToDodata = filteredData
        updateFilteredData()
    }

    @IBAction func onsegmentChange(_ sender: Any) {
        updateFilteredData()
    }
 
    @IBAction func onAscSwitch(_ sender: Any) {
        if asceSwitch.isOn {
            sortTasks(ascending: true)
                if descSwitch.isOn {
                    descSwitch.setOn(false, animated: true)
                }
              } else {
                  updateFilteredData()
              }   
    }
    
    @IBAction func onDescSwitch(_ sender: Any) {
        if descSwitch.isOn {
                  sortTasks(ascending: false)
                  if asceSwitch.isOn {
                      asceSwitch.setOn(false, animated: true)
                  }
              } else {
                  updateFilteredData()
              }
    }
    
    func handleSegmentChange() {
        switch filterSegment.selectedSegmentIndex {
        case 1:
            filteredData = data.filter { $0.status == "Pending" }
            ToDodata = filteredData
        case 2:
            filteredData = data.filter { $0.status == "Completed" }
            ToDodata = filteredData
        default:
            filteredData = data
            ToDodata = filteredData
        }
    }

    func updateFilteredData() {
        handleSegmentChange()
        if asceSwitch.isOn {
                   sortTasks(ascending: true)
               } else if descSwitch.isOn {
                   sortTasks(ascending: false)
               }
        table.reloadData()
    }

    func sortTasks(ascending: Bool) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy, h:mm a"
        
        filteredData.sort { (task1, task2) -> Bool in
            if let date1 = dateFormatter.date(from: task1.dueTime),
               let date2 = dateFormatter.date(from: task2.dueTime) {
                return ascending ? date1 < date2 : date1 > date2
            }
            return false
        }
        ToDodata.sort { (task1, task2) -> Bool in
            if let date1 = dateFormatter.date(from: task1.dueTime),
               let date2 = dateFormatter.date(from: task2.dueTime) {
                return ascending ? date1 < date2 : date1 > date2
            }
            return false
        }
        table.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = filteredData[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "TaskCellfilter", for: indexPath) as! TaskFilterCellTableViewCell
        cell.task.text = row.title
        cell.iconimg.image = row.icon
        cell.duetime.text = "Due \(row.dueTime)"
        cell.taskStatus.text = row.status
        return cell
    }
}
