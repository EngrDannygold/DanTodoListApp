//
//  DarkModeModalView.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 28/06/2025.
//

import UIKit

class appThemeModalView: UIView {
    @IBOutlet var appThemeView: UIView!
    @IBOutlet weak var appThemeSegmentControl: UISegmentedControl!
    var delegate: appThemeModalDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    func initSubviews() {
        let nib = UINib(nibName: "appThemeModalView", bundle: nil)
        nib.instantiate(withOwner: self)
        appThemeView.frame = bounds
        self.addSubview(appThemeView)
    }
    override func layoutSubviews() {
        appThemeView.layer.cornerRadius = 8
        appThemeSegmentControl.selectedSegmentIndex = 1
//        appThemeSelected(appThemeSegmentControl)
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        delegate?.closeView()
    }
    
    @IBAction func appThemeSelected(_ sender: UISegmentedControl) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return}
        guard let window = windowScene.windows.first else {return}
        
        switch sender.selectedSegmentIndex {
        case 0:
            window.overrideUserInterfaceStyle = .light
        case 1:
            window.overrideUserInterfaceStyle = .dark
        case 2:
            window.overrideUserInterfaceStyle = .unspecified
        default:
            return
        }
    }
}
