//
//  UIColor+Random.swift
//  HikingAI
//
//  Created by Yaroslav Spirin on 16/11/2019.
//  Copyright © 2019 Yaroslav Spirin. All rights reserved.
//

import UIKit

extension UIColor {
    public static func random() -> UIColor {
        return UIColor(red: CGFloat((arc4random() % 255)) / 255.0,
                       green: CGFloat((arc4random() % 255)) / 255.0,
                       blue: CGFloat((arc4random() % 255)) / 255.0,
                       alpha: 1.0)
    }
}
