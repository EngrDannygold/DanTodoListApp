//
//  RoundedButton.swift
//  Dan Todo List App
//
//  Created by MACBOOK on 02/07/2025.
//

import UIKit

class RoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.link
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = layer.frame.width / 2
    }

}
