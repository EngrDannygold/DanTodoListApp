//
//  TaskTableViewCell.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 20/06/2025.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var isCompleteImageView: UIImageView!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var taskViewSideDesign: UIView!
    var task: TaskModel?
    var delegate: TaskTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        categoryView.layer.cornerRadius = categoryView.frame.height / 2
        taskView.clipsToBounds = true
        taskView.layer.cornerRadius = 8
        descriptionLabel.numberOfLines = 0
        selectionStyle = .none
}
    

    func configure(withTask task: TaskModel, delegate: TaskTableViewCellDelegate) {
        categoryView.backgroundColor = task.category.secondaryColor
        taskViewSideDesign.backgroundColor = task.category.color
        categoryLabel.text = task.category.rawValue
        categoryLabel.textColor = task.category.color
        descriptionLabel.text = task.caption
        dateLabel.text = task.date.formatted()
        
        isCompleteImageView.image = task.isComplete ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(isComplete))
        isCompleteImageView.addGestureRecognizer(tap)
        isCompleteImageView.isUserInteractionEnabled = true
        self.task = task
        self.delegate = delegate
    }
    @objc func isComplete() {
        task?.isComplete.toggle()
        delegate?.isComplete(id: task!.id, complete: task!.isComplete)
        isCompleteImageView.image = task!.isComplete ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
    }

        
    @IBAction func editButtonTapped(_ sender: UIButton) {
        guard let id = task?.id else {return}
        delegate?.editTask(id: id)
    }
}


