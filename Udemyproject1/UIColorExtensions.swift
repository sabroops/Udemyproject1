//
//  UIColorExtensions.swift
//  Udemyproject1
//
//  Created by Sabrina on 8/29/23.
//

import Foundation
import UIKit

extension UIColor {
    static func random() -> UIColor {
        UIColor(displayP3Red: Double.random(in: 0...1), green: Double.random(in:0...1), blue: Double.random(in:0...1), alpha:1)
    }
}
