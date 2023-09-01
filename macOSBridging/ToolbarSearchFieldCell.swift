//
//  ToolbarSearchFieldCell.swift
//  
//  Created by Deniz Nessa on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import AppKit

class ToolbarSearchFieldCell: NSSearchFieldCell {
    
    // this odd looking selector saves the original action that is associated with the
    // cancel button in the search bar. Because we are going to override the default action
    // we don't want to lose whatever the cancel button was doing internally
    private var defaultCancelButtonAction: Selector?
    weak var cancelButtonDelegate: CancelSearchDelegate?
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(textCell string: String) {
        super.init(textCell: string)
        commonInit()
    }
    
    private func commonInit() {
        isBordered = true
        isBezeled = true
        isSelectable = true
        isEditable = true
        
        //save the original action that was associated with the cancel button. based on
        //debugging, original action is calling a private method called "_searchFieldCancel:"
        defaultCancelButtonAction = cancelButtonCell?.action
        
        //we are now replacing the original action with the one that we control
        //once our method is called, we will inform our delegate that the cancel was triggered
        //as well as we will call the original action
        cancelButtonCell?.action = #selector(didClickSearchFieldCancelButton(_:))
        
    }
    
    @objc func didClickSearchFieldCancelButton(_ sender: Any) {
        cancelButtonDelegate?.didClickCancel()
        if let validOriginalAction = defaultCancelButtonAction, responds(to: validOriginalAction) {
            perform(validOriginalAction)
        }
    }
    
    
}
