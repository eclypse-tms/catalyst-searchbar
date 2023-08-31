//
//  ToolbarSearchField.swift
//  
//  Created by Turker Nessa Kucuk on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import AppKit

class ToolbarSearchField: NSSearchField, CancelSearchDelegate {
    
    weak var cancelButtonDelegate: CancelSearchDelegate?
    
    convenience init() {
        self.init(frame: .zero)
        
        let customCell = ToolbarSearchFieldCell()
        customCell.cancelButtonDelegate = self
        cell = customCell
        //delegate = customCell
    }
    
    func didClickCancel() {
        cancelButtonDelegate?.didClickCancel()
        self.resignFirstResponder()
    }
}
