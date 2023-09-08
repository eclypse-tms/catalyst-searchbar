//
//  CustomSearchbarToolItem.swift
//  
//  Created by Deniz Nessa on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import AppKit

@objc
class CustomSearchbarToolItem: NSToolbarItem, NSSearchFieldDelegate, CancelSearchDelegate {
    private let searchField = ToolbarSearchField()
    
    override init(itemIdentifier: NSToolbarItem.Identifier) {
        super.init(itemIdentifier: itemIdentifier)
        
        searchField.bezelStyle = .roundedBezel
        searchField.placeholderString = NSLocalizedString("search_placeholder", comment: "")
        searchField.stringValue = ""
        searchField.delegate = self
        searchField.cancelSearchDelegate = self
        searchField.lineBreakMode = .byClipping
        
        self.view = searchField
        
        visibilityPriority = .high
    }
    
    func controlTextDidChange(_ obj: Notification) {
        //according to Apple Docs, we can retrieve the text value from the userInfo dictionary in Notification object
        if let attachedTextView = obj.userInfo?["NSFieldEditor"] as? NSTextView {
            //using notification center, we can relay this message back to the ViewController
            NotificationCenter.default.post(name: InternalNotification.toolbarSearchBarTextChanged.name, object: attachedTextView.string)
        }
    }
    
    func didClickCancel() {
        //as of macOS 13 - there appears to be a bug with the search bar cancel button
        //sometimes it doesn't trigger controlTextDidChange(_:) event even though the text has been cleared visually
        //in order to overcome this problem, we are using the classic delegate mechanism to retrieve events
        //from the ToolbarSearchFieldCell object
        NotificationCenter.default.post(name: InternalNotification.toolbarSearchBarTextChanged.name, object: "")
    }
    
    func control(_ control: NSControl, textShouldEndEditing fieldEditor: NSText) -> Bool {
        return true //optional
    }
}
