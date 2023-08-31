//
//  CancelSearchDelegate.swift
//  
//  Created by Deniz Nessa on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import Foundation

/// There appears to be a bug with NSSearchFieldCell's cancel button as of macOS 13.x.
/// Clicking the cancel button in the search bar does not consistently trigger the search bar text changed event
/// We are creating this protocol to ensure when cancel button is clicked, we manually fire the text changed event with empty text
protocol CancelSearchDelegate: AnyObject {
    /// triggered when user clicks the clear button on search box
    func didClickCancel()
}
