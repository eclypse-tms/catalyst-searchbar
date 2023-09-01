//
//  ToolbarSearchField.swift
//  
//  Created by Deniz Nessa on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import AppKit

/// ToolbarSearchField is wrapper around ToolbarSearchFieldCell
class ToolbarSearchField: NSSearchField, CancelSearchDelegate {
    
    weak var cancelSearchDelegate: CancelSearchDelegate?
    
    convenience init() {
        self.init(frame: .zero)
        
        let customCell = ToolbarSearchFieldCell()
        customCell.cancelButtonDelegate = self // in order to receive search cancelled button clicks
        cell = customCell
    }
    
    func didClickCancel() {
        //we need to relay the cancel search trigger to SearchbarToolItem
        cancelSearchDelegate?.didClickCancel()
        self.resignFirstResponder() //optional
    }
}
