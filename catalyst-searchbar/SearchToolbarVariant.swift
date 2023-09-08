//
//  SearchToolbarVariant.swift
//  catalyst-searchbar
//
//  Created by Turker Nessa on 9/7/23.
//

import Foundation

enum SearchToolbarVariant: Int {
    /// uses UISearchBar from UIKit as a custom view in NSToolbarItem
    case uiSearchBar
    
    /// uses NSSearchBar from AppKit as a custom view in NSToolbarItem
    case nsSearchBarCustom
    
    /// uses prebuilt NSSearchToolbarItem from AppKit
    case nsSearchBarDefault
}
