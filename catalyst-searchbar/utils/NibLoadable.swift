//
//  NibLoadable.swift
//  
//  Created by Deniz Nessa on 8/30/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import UIKit

/// helper protocol that makes loading & registering cells easier
protocol NibLoadable: AnyObject {
    static var nibName: String { get }
    static var nibBundle: Bundle { get }
}

extension NibLoadable {
    
    static var nibName: String {
        return String(describing: self.self)
    }
    
    static var nibBundle: Bundle {
        return Bundle(for: self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nibBundle)
    }
    
}

extension NibLoadable where Self: UIView {
    
    static var fromNib: Self {
        return nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
    
}
