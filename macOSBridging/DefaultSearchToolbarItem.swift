//
//  DefaultSearchToolbarItem.swift
//  macOSBridging
//
//  Created by Turker Nessa on 9/7/23.
//

import AppKit

class DefaultSearchToolbarItem: NSSearchToolbarItem, NSSearchFieldDelegate {
    private var defaultCancelButtonAction: Selector?
    
    override init(itemIdentifier: NSToolbarItem.Identifier) {
        super.init(itemIdentifier: itemIdentifier)
        
        preferredWidthForSearchField = 180
        resignsFirstResponderWithCancel = true
        searchField.delegate = self
        if let searchFieldCell = searchField.cell as? NSSearchFieldCell {
            //save the original action that was associated with the cancel button
            //debugging shows that original action is calling a private method called "_searchFieldCancel:"
            defaultCancelButtonAction = searchFieldCell.cancelButtonCell?.action
            
            //we are now replacing the original action with the one that we control
            //once our method is called, we will post the search bar text changed notification
            //as well as we will call the original action that was associated with the cancel button
            searchFieldCell.cancelButtonCell?.action = #selector(didClickSearchFieldCancelButton(_:))
        }
    }
    
    func controlTextDidChange(_ obj: Notification) {
        //according to Apple Docs, we can retrieve the text value from the userInfo dictionary in Notification object
        if let attachedTextView = obj.userInfo?["NSFieldEditor"] as? NSTextView {
            //using notification center, we can relay this message back to the ViewController
            NotificationCenter.default.post(name: InternalNotification.toolbarSearchBarTextChanged.name, object: attachedTextView.string)
        }
    }
    
    @objc func didClickSearchFieldCancelButton(_ sender: Any) {
        //user clicked cancel - post a notification with empty text
        NotificationCenter.default.post(name: InternalNotification.toolbarSearchBarTextChanged.name, object: "")
        
        if let validOriginalCancelAction = defaultCancelButtonAction, responds(to: validOriginalCancelAction) {
            //now run the original cancel action
            perform(validOriginalCancelAction)
        }
    }
}
