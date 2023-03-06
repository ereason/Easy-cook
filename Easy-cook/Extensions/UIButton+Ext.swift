//
//  UIButton+Ext.swift
//  Easy-cook
//
//  Created by  Pavel on 06/03/2023.

import UIKit
extension UIButton {
    // grey shadow
     func getShadow(_ button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.5
//        button.clipsToBounds
        button.layer.masksToBounds = true
    }
}
