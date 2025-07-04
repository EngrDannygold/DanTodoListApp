//
//  DarkModeViewController.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 28/06/2025.
//

import Foundation
import UIKit

protocol appThemeModalDelegate {
    func closeView()
}
class appThemeViewController: UIViewController {
    lazy var modalView: UIView = {
        let height: CGFloat = 180
        let width: CGFloat = view.frame.width - 30
        let xPos = (view.frame.width - width) / 2
        let yPos = (view.frame.height - height) / 2
        let frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        let modal = appThemeModalView(frame: frame)
        modal.delegate = self
        return modal
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
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

extension appThemeViewController: appThemeModalDelegate {
    
    func closeView() {
        dismiss(animated: true)
    }
}

