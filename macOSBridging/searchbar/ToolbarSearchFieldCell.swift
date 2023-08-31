//
//  ToolbarSearchFieldCell.swift
//  
//  Created by Deniz Nessa on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import AppKit

class ToolbarSearchFieldCell: NSSearchFieldCell {
    
    private var originalAction: Selector?
    weak var cancelButtonDelegate: CancelSearchDelegate?
    
    override init(textCell string: String) {
        super.init(textCell: string)
        
        isBordered = true
        isBezeled = true
        isSelectable = true
        isEditable = true
        
        if let validCancelButton = cancelButtonCell {
            //save the original action that was associated with the cancel button
            //then replace the action with the one that we control
            //once our selector is called - we will
            originalAction = validCancelButton.action
            validCancelButton.action = #selector(didClickSearchFieldCancelButton(_:))
        }
    }
    
    @objc func didClickSearchFieldCancelButton(_ sender: Any) {
        cancelButtonDelegate?.didClickCancel()
        if let validOriginalAction = originalAction, responds(to: validOriginalAction) {
            perform(validOriginalAction)
        }
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
