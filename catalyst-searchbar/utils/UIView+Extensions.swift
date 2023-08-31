//
//  UIView+Extensions.swift
//  
//  Created by Deniz Nessa on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import UIKit

extension UIView {
    func roundCorners(cornerRadius: CGFloat) {
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
