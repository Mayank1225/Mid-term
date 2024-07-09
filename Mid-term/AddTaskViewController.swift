import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var dateAndTime: UITextField!
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDescription: UITextField!
    
    @IBOutlet weak var ImageChoose: UIButton!
    @IBOutlet weak var selectIcon: UIButton!
    
    var selectedIcon: UIImage? = UIImage(systemName: "bookmark")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let datePickerImage = UIImage(systemName: "calendar")
        
        addLeftImage(textField: dateAndTime, Image: datePickerImage!)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 500)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        
        dateAndTime.inputView = datePicker
        dateAndTime.text = formateDate(date: Date())

        setImage()
        ImageChoose.setImage(selectedIcon, for: .normal)
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        dateAndTime.text = formateDate(date: datePicker.date)
    }
    
    func addLeftImage(textField: UITextField, Image img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        textField.leftView = leftImageView
        textField.leftViewMode = .always
    }
    
    @IBAction func onClickSelect(_ sender: Any) {
        // Implement icon selection logic here
    }
    
    func setImage() {
        ImageChoose.menu = UIMenu(children: [
            UIAction(title: "bookmark", handler: { [weak self] action in
                self?.selectIconWithName(name: action.title)
            }),
            UIAction(title: "leaf", handler: { [weak self] action in
                self?.selectIconWithName(name: action.title)
            }),
            UIAction(title: "cart", handler: { [weak self] action in
                self?.selectIconWithName(name: action.title)
            }),
            UIAction(title: "briefcase", handler: { [weak self] action in
                self?.selectIconWithName(name: action.title)
            }),
            UIAction(title: "figure.walk", handler: { [weak self] action in
                self?.selectIconWithName(name: action.title)
            }),
            UIAction(title: "book", handler: { [weak self] action in
                self?.selectIconWithName(name: action.title)
            }),
            UIAction(title: "hammer", handler: { [weak self] action in
                self?.selectIconWithName(name: action.title)
            }),
            UIAction(title: "phone", handler: { [weak self] action in
                self?.selectIconWithName(name: action.title)
            })
        ])
        ImageChoose.showsMenuAsPrimaryAction = true
        ImageChoose.changesSelectionAsPrimaryAction = true
    }
    
    func selectIconWithName(name: String) {
        selectedIcon = UIImage(systemName: name)
        ImageChoose.setImage(selectedIcon, for: .normal)
    }
    
    @IBAction func addTask(_ sender: Any) {
        var errorMessage = ""

        if taskTitle.text?.isEmpty == true {
            errorMessage += "Task title is required.\n"
        }
        if taskDescription.text?.isEmpty == true {
            errorMessage += "Task description is required.\n"
        }
        if dateAndTime.text?.isEmpty == true {
            errorMessage += "Date and Time is required.\n"
        }
      
        if !errorMessage.isEmpty {
            let errorAlert = UIAlertController(title: "Please Enter below field", message: errorMessage, preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(errorAlert, animated: true)
        } else {
            let newTask = Todo(icon: selectedIcon!, title: taskTitle.text!, dueTime: dateAndTime.text!, status: "Pending", description: taskDescription.text!)
            
            data.insert(newTask, at: 0)
            
            let successAlert = UIAlertController(title: "Success", message: "Task successfully created.", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.taskTitle.text = ""
                self.taskDescription.text = ""
                self.dateAndTime.text = self.formateDate(date: Date())
                self.ImageChoose.setImage(self.selectedIcon, for: .normal)
                
                if let tabBarController = self.tabBarController {
                    tabBarController.selectedIndex = 0
                }
            }))
            self.present(successAlert, animated: true)
        }
    }
    
    func formateDate(date: Date) -> String {
        let formate = DateFormatter()
        formate.dateFormat = "MMMM dd yyyy, h:mm a"
        return formate.string(from: date)
    }
}
