//
//  UITableView+Extensions.swift
//  X
//
//  Created by iosDev on 30.11.2022.
//

import UIKit

extension UITableView {
    
    public func registerNib<T: UITableViewCell>(for type: T.Type) {
        self.register(type.nib, forCellReuseIdentifier: type.identifier)
    }
    
    public func deque<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! T
    }
    
}
