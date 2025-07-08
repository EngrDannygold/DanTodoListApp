//
//  NewTaskViewController.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 20/06/2025.
//

import UIKit

protocol NewTaskViewDelegate: AnyObject {
    func closeView()
    func presentErrorAlert(title: String, message: String)
}

class NewTaskViewController: UIViewController {
    lazy var modalView: UIView = {
        let height: CGFloat = 450
        let width: CGFloat = view.frame.width - 30
        let xPos = (view.frame.width - width) / 2
        let yPos = (view.frame.height - height) / 2
        let frame = CGRect(x: xPos, y: yPos, width: width, height: height)

        let modal = NewTaskModalView(frame: frame, task: task)
        modal.delegate = self
        return modal
    }()

    var task: TaskModel?

    init(task: TaskModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        self.task = task
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        modalView.transform = CGAffineTransform(scaleX: 0, y: 0)
        view.addSubview(modalView)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        modalView.presentViewBounceAnimation()
    }

}
extension NewTaskViewController: NewTaskViewDelegate {
    func presentErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    func closeView() {
        dismiss(animated: true)
    }
}


