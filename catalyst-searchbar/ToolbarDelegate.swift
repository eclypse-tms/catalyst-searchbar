//
//  ToolbarDelegate.swift
//  
//  Created by Turker Nessa Kucuk on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import UIKit

class ToolbarDelegate: NSObject {
    var shouldUseNSSearchBar = false
}

extension ToolbarDelegate: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NotificationCenter.default.post(name: CustomNotification.toolbarSearchBarTextChanged.name, object: searchText)
    }
}

#if targetEnvironment(macCatalyst)
extension ToolbarDelegate: NSToolbarDelegate {
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        if shouldUseNSSearchBar {
            return [.flexibleSpace, .favorites, .nsSearchBar]
        } else {
            return [.flexibleSpace, .favorites, .uiSearchBar]
        }
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        var toolbarItemToInsert: NSToolbarItem?
        switch itemIdentifier {
        case .uiSearchBar:
            let uiSearchBar = UISearchBar()
            uiSearchBar.backgroundImage = UIImage()
            uiSearchBar.placeholder = NSLocalizedString("search_placeholder", comment: "")
            uiSearchBar.sizeToFit() //as of XCode 14 and macOS 13 - I could not find a way to correctly size this search bar
            uiSearchBar.delegate = self
            let uibarButtonItem = UIBarButtonItem(customView: uiSearchBar)
            let item = NSToolbarItem(itemIdentifier: itemIdentifier, barButtonItem: uibarButtonItem)
            
            toolbarItemToInsert = item
        case .nsSearchBar:
            if let frameworksPath = Bundle.main.privateFrameworksPath {
                let bundlePath = "\(frameworksPath)/macOSBridging.framework"
                do {
                    try Bundle(path: bundlePath)?.loadAndReturnError()
                    _ = Bundle(path: bundlePath)!
                    if let searchbarToolItemClass = NSClassFromString("macOSBridging.SearchbarToolItem") as? NSToolbarItem.Type {
                        let newItemToAdd = searchbarToolItemClass.init(itemIdentifier: itemIdentifier)
                        newItemToAdd.isBordered = false
                        toolbarItemToInsert = newItemToAdd
                        print("Successfully loaded NSSearchBar into our toolbar!!!")
                    }
                } catch {
                    print("error while loading the dependent framework: \(error.localizedDescription)")
                }
            }
        case .favorites:
            let item = NSToolbarItem(itemIdentifier: itemIdentifier)
            item.image = UIImage(systemName: "heart")
            item.label = "Favorites"
            item.action = #selector(ViewController.didClickOnFavorites(_:))
            toolbarItemToInsert = item
        default:
            break
        }
        
        return toolbarItemToInsert
    }
}

extension NSToolbarItem.Identifier {
    static let favorites = NSToolbarItem.Identifier("topDomain.company.application.toolbaritem.favorites")
    static let uiSearchBar = NSToolbarItem.Identifier("topDomain.company.application.toolbaritem.uisearchbar")
    static let nsSearchBar = NSToolbarItem.Identifier("topDomain.company.application.toolbaritem.nssearchbar")
}

#endif


