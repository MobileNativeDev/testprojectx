//
//  Reusable.swift
//  X
//
//  Created by iosDev on 30.11.2022.
//

import UIKit

protocol Reusable {}

extension Reusable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension Reusable where Self: UITableViewCell {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
    
}

extension UIView: Reusable {}
extension UIViewController: Reusable {}
