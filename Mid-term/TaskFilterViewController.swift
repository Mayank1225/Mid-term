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
        updateFilteredData()
    }

    @IBAction func onsegmentChange(_ sender: Any) {
//        updateFilteredData()
        handleSegmentChange()
    }
 
    @IBAction func onAscSwitch(_ sender: Any) {
    }
    
    @IBAction func onDescSwitch(_ sender: Any) {
    }
    
    @IBAction func onSwitchChange(_ sender: UISwitch) {
        updateFilteredData()
    }

    func handleSegmentChange() {
        switch filterSegment.selectedSegmentIndex {
        case 1:
            filteredData = data.filter { $0.status == "Pending" }
            print("kfnhgnkr\n\n\n");
        case 2:
            filteredData = data.filter { $0.status == "Completed" }
        default:
            filteredData = data
        }
    }

    func updateFilteredData() {
        if asceSwitch.isOn {
//            filteredData = data.filter { $0.status == "Pending" }
            sortTasks(ascending: true)
            descSwitch.setOn(false, animated: true)
            
        } else if descSwitch.isOn {
            sortTasks(ascending: false)
            asceSwitch.setOn(false, animated: true)
//            handleSegmentChange()
        }
        table.reloadData()
//        DispatchQueue.main.async {
//            self.table.reloadData()
//
//        }
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
