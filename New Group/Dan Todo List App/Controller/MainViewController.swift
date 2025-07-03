//
//  ViewController.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 15/06/2025.
//

import UIKit
protocol TaskTableViewCellDelegate {
    func isComplete(id: String, complete: Bool)
    func editTask(id: String)
}
class MainViewController: UIViewController {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var taskTableView: UITableView!
    var taskArray: [TaskModel] = []
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.link
        button.tintColor = UIColor.white
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(1.4, 1.4, 1.4)
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.clipsToBounds = true
        titleView.layer.cornerRadius = 24
        titleView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        taskTableView.dataSource = self
//        taskTableView.delegate = self
        taskTableView.estimatedRowHeight = 80
        taskTableView.rowHeight = UITableView.automaticDimension
        taskTableView.tableFooterView = UIView()
        taskTableView.separatorStyle = .none
        view.addSubview(addButton)
        
        NotificationCenter.default.addObserver(self, selector: #selector(createTask(_:)), name: .notificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editTask(_:)), name: NSNotification.Name("com.dannygold.swift.editTask"), object: nil)

    }
    override func viewDidLayoutSubviews() {
        let safeAreaButtom = view.safeAreaInsets.bottom
        let width: CGFloat = 60
        let height: CGFloat = 60
        addButton.layer.cornerRadius = addButton.frame.height / 2
        let xPos = view.frame.width / 2 - width / 2
        let yPos = view.frame.height - safeAreaButtom - height
        addButton.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
    }
    @objc func addButtonPressed() {
        let newTaskVC = NewTaskViewController()
        present(newTaskVC, animated: true)
    }
    @objc func createTask(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let newTask = userInfo["newTask"] as? TaskModel {
                taskArray.append(newTask)
                taskTableView.reloadData()
            }
        }
    }
    @objc func editTask(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let oldTask = userInfo["oldTask"] as? TaskModel else {
            return
        }
                let index = taskArray.firstIndex { task in
                    task.id == oldTask.id
                }
        guard let index = index else {
                    return
                }
                taskArray[index] = oldTask
                taskTableView.reloadData()
            }
    @IBAction func darkModeButtonPressed(_ sender: UIButton) {
        let darkModeVC = appThemeViewController()
        present(darkModeVC, animated: true)
    }
}





extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCellId", for: indexPath) as! TaskTableViewCell
        let tasks = taskArray[indexPath.row]
        cell.configure(withTask: tasks, delegate: self)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskArray.remove(at: indexPath.row)
            taskTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
//extension MainViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let tasks = taskArray[indexPath.row]
//        let oldTaskVC = NewTaskViewController(task: tasks)
//        present(oldTaskVC, animated: true)
//    }
//}
extension MainViewController: TaskTableViewCellDelegate {
    func editTask(id: String) {
        
        let tasks = taskArray.first { task in
            task.id == task.id
        }
        guard let tasks = tasks else {return}
        let oldTaskVC = NewTaskViewController(task: tasks)
        present(oldTaskVC, animated: true)
    }
    
    func isComplete(id: String, complete: Bool) {
        let taskindex = taskArray.firstIndex { task in
            task.id == task.id
        }
        guard let taskindex = taskindex else {return}
        var tasks = taskArray[taskindex]
        tasks.isComplete = complete
    }
}
