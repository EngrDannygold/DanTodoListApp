//
//  ViewController.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 15/06/2025.
//

import UIKit
import CoreData
protocol TaskTableViewCellDelegate {
    func isComplete(id: ObjectIdentifier, complete: Bool)
    func editTask(id: ObjectIdentifier)
}
class MainViewController: UIViewController {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var taskTableView: UITableView!
    var taskArray: [TaskModel] = []
    let context = Todolist.shared.managedContext
    
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
        setupView()
        setupNotification()
        fetchData()
    }
    private func setupView() {
        titleView.clipsToBounds = true
        titleView.layer.cornerRadius = 24
        titleView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        taskTableView.dataSource = self
        taskTableView.estimatedRowHeight = 80
        taskTableView.rowHeight = UITableView.automaticDimension
        taskTableView.tableFooterView = UIView()
        taskTableView.separatorStyle = .none
        view.addSubview(addButton)
    }
    
    private func setupNotification() {
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
//        if let userInfo = notification.userInfo {
//            if let newTask = userInfo["newTask"] as? TaskModel {
//                
//                let newTaskC = TaskModel(context: context)
//                newTaskC.category = newTask.category
//                newTaskC.caption = newTask.caption
//                newTaskC.date = newTask.date
//                newTaskC.isComplete = newTask.isComplete
//                
//                do {
//                    try context.save()
//                } catch {
//                    let e = error
//                    print("error save data: \(e.localizedDescription)")
//                }
//            }
//        }
        fetchData()
    }
    @objc func editTask(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let oldTask = userInfo["oldTask"] as? TaskModel else {
            return
        }
        let tasks = taskArray.first { task in
            task.id == oldTask.id
        }
        
        if let oldTaskC = tasks {
            oldTaskC.category = oldTask.category
            oldTaskC.caption = oldTask.caption
            oldTaskC.date = oldTask.date
            oldTaskC.isComplete = oldTask.isComplete
        }
        do {
            try context.save()
        } catch {
            let e = error
            print("error save data: \(e.localizedDescription)")
        }
        fetchData()
    }
    func fetchData() {
        let request = TaskModel.fetchRequest()
        
        do {
            taskArray = try context.fetch(request)
        } catch {
            let e = error
            print("error fetching data: \(e.localizedDescription)")
        }
        DispatchQueue.main.async {
            self.taskTableView.reloadData()
        }
    }
    @IBAction func darkModeButtonPressed(_ sender: UIButton) {
        let darkModeVC = appThemeViewController()
        present(darkModeVC, animated: true)
    }
}




//MARK: - Conforms to UITableViewDataSource:
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
            let taskToRemove = taskArray[indexPath.row]
            context.delete(taskToRemove)
            taskArray.remove(at: indexPath.row)

            do {
                try context.save()
            } catch {
                print("Failed to delete task: \(error)")
            }
            taskTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
//MARK: - Conforms to TaskTableViewCellDelegate:
extension MainViewController: TaskTableViewCellDelegate {
    
    func editTask(id: ObjectIdentifier) {
        let tasks = taskArray.first { task in
            task.id == id
        }
        guard let tasks = tasks else {return}
        let oldTaskVC = NewTaskViewController(task: tasks)
        present(oldTaskVC, animated: true)
    }
    
    func isComplete(id: ObjectIdentifier, complete: Bool) {
        let tasks = taskArray.first { task in
            task.id == id
        }
        guard let tasks = tasks else {return}
        tasks.isComplete = complete
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        fetchData()
    }
}
