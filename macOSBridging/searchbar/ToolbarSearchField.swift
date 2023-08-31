//
//  ToolbarSearchField.swift
//  
//  Created by Deniz Nessa on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import AppKit

/// ToolbarSearchField
class ToolbarSearchField: NSSearchField, CancelSearchDelegate {
    
    weak var cancelButtonDelegate: CancelSearchDelegate?
    
    convenience init() {
        self.init(frame: .zero)
        
        let customCell = ToolbarSearchFieldCell()
        customCell.cancelButtonDelegate = self
        cell = customCell
    }
    
    func didClickCancel() {
        cancelButtonDelegate?.didClickCancel()
        self.resignFirstResponder()
    }
}
