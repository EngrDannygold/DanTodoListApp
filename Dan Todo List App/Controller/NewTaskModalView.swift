//
//  NewTaskModalView.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 22/06/2025.
//

import UIKit

class NewTaskModalView: UIView {
    @IBOutlet weak private var descriptionTextView: UITextView!
    @IBOutlet weak private var categoryPickerView: UIPickerView!
    @IBOutlet private var containerView: UIView!
    var task: TaskModel?

    weak var delegate: NewTaskViewDelegate?
    
    var editCaption: String {
        get {
            return descriptionTextView.text
        }
        set {
            descriptionTextView.text = newValue
        }
    }
    init(frame: CGRect, task: TaskModel?) {
        super.init(frame: frame)
        self.task = task
        initSubview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubview()
    }
    
    func initSubview() {
        let nib = UINib(nibName: "NewTaskModalView", bundle: nil)
        nib.instantiate(withOwner: self)
        
        descriptionTextView.layer.borderWidth = 2
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.cornerRadius = 8

        descriptionTextView.delegate = self
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
//        let ads = CategoryModel.Exercise.rawValue
        if let task = task {
            guard let selectedRow = CategoryModel.allCases.firstIndex(of: task.category) else {
                return
            }
            descriptionTextView.text = task.caption
            descriptionTextView.textColor = UIColor.label
            categoryPickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        } else {
            descriptionTextView.text = "Add Your Caption..."
            descriptionTextView.textColor = UIColor.placeholderText
        }
        
        containerView.frame = bounds
        addSubview(containerView)
    }
    override func layoutSubviews() {
        containerView.layer.cornerRadius = 8
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        delegate?.closeView()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if descriptionTextView.textColor == UIColor.label, !descriptionTextView.text.isEmpty, descriptionTextView.text.count > 3 {
            let selectedRow = categoryPickerView.selectedRow(inComponent: 0)
            let selectedCategory = CategoryModel.allCases[selectedRow]
            guard let caption = descriptionTextView.text else {
                return
            }
            if let task = task {
                let oldTask = TaskModel(id: task.id, category: selectedCategory, caption: caption, date: task.date, isComplete: task.isComplete)
                let userInfo: [String: Any] = ["oldTask": oldTask]
                NotificationCenter.default.post(name: Notification.Name("com.dannygold.swift.editTask"), object: nil, userInfo: userInfo)
            } else {
                let id = UUID().uuidString
                let newTask = TaskModel(id: id, category: selectedCategory, caption: caption, date: Date(), isComplete: false)
                let userInfo: [String: Any] = ["newTask": newTask]
                NotificationCenter.default.post(name: .notificationName, object: nil, userInfo: userInfo)
            }
            delegate?.closeView()
        } else {
            descriptionTextView.text = "Please enter a text here..."
            descriptionTextView.textColor = UIColor.placeholderText
            descriptionTextView.resignFirstResponder()
        }
    }
}

extension NewTaskModalView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CategoryModel.allCases.count
    }
    
}

extension NewTaskModalView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel: UILabel? = view as? UILabel
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = .systemFont(ofSize: 16, weight: .regular)
            pickerLabel?.textAlignment = .center
        }
        let category = CategoryModel.allCases[row]
        pickerLabel?.text = category.rawValue
        
        return pickerLabel!
    }
}

extension NewTaskModalView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.textColor == UIColor.placeholderText {
            descriptionTextView.text = ""
            descriptionTextView.textColor = UIColor.label
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = "Add Your Caption..."
            descriptionTextView.textColor = UIColor.placeholderText
        }
    }
}
extension Notification.Name {
    static let notificationName = Notification.Name("com.dannygold.swift.createTask")
}


