//
//  SearchbarToolItem.swift
//  
//  Created by Deniz Nessa on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import AppKit

@objc
class SearchbarToolItem: NSToolbarItem, NSSearchFieldDelegate, CancelSearchDelegate {
    private let searchField = ToolbarSearchField()
    
    override init(itemIdentifier: NSToolbarItem.Identifier) {
        super.init(itemIdentifier: itemIdentifier)
        
        searchField.bezelStyle = .roundedBezel
        //textField.action = NSSelectorFromString("searchBarSearchQuery:")
        searchField.placeholderString = NSLocalizedString("search_placeholder", comment: "")
        searchField.stringValue = ""
        searchField.delegate = self
        searchField.cancelButtonDelegate = self
        searchField.lineBreakMode = .byClipping
        
        self.view = searchField
        
        visibilityPriority = .high
    }
    
    func controlTextDidChange(_ obj: Notification) {
        if let attachedTextView = obj.userInfo?["NSFieldEditor"] as? NSTextView {
            NotificationCenter.default.post(name: InternalNotification.toolbarSearchBarTextChanged.name, object: attachedTextView.string)
        }
    }
    
    func didClickCancel() {
        NotificationCenter.default.post(name: InternalNotification.toolbarSearchBarTextChanged.name, object: "")
    }
    
    func control(_ control: NSControl, textShouldEndEditing fieldEditor: NSText) -> Bool {
        return true
    }
}
