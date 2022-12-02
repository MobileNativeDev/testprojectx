//
//  String+Extensions.swift
//  X
//
//  Created by iosDev on 02.12.2022.
//

import Foundation

extension String {
    
   public func isThruncate() -> Bool {
       let length = 100
       let nsString = self as NSString
       if nsString.length >= length {
           return true
       }
       return  false
   }
    
}
