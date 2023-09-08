//
//  ToolbarDelegate.swift
//  
//  Created by Deniz Nessa on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import UIKit

class ToolbarDelegate: NSObject {
    /// when true the example app uses AppKit's Search Bar. Otherwise it embeds a
    /// UIKit Search Bar in the Toolbar.
    var searchBarVariant = SearchToolbarVariant.uiSearchBar
}

extension ToolbarDelegate: UISearchBarDelegate {
    // one way to communicate between your Toolbar and ViewControllers is to use NotificationCenter.
    // please note that this is just an example. there are other ways to to receive messages
    // from the ToolbarDelegate.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NotificationCenter.default.post(name: InternalNotification.toolbarSearchBarTextChanged.name, object: searchText)
    }
}

#if targetEnvironment(macCatalyst)
extension ToolbarDelegate: NSToolbarDelegate {
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        var itemIdentifiersInToolbar: [NSToolbarItem.Identifier] = [.flexibleSpace, .share]
        switch searchBarVariant {
        case .uiSearchBar:
            itemIdentifiersInToolbar.append(.uiSearchBar)
        case .nsSearchBarCustom:
            itemIdentifiersInToolbar.append(.nsSearchBarCustom)
        case .nsSearchBarDefault:
            itemIdentifiersInToolbar.append(.nsSearchBarDefault)
        }
        
        return itemIdentifiersInToolbar
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
            
            // !!! Warning !!!
            // using custom views is not supported when targeting macOS 12 or earlier
            // see https://developer.apple.com/documentation/appkit/nstoolbaritem/3375792-init
            let uibarButtonItem = UIBarButtonItem(customView: uiSearchBar)
            uibarButtonItem.width = 180
            let newItemToAdd = NSToolbarItem(itemIdentifier: itemIdentifier, barButtonItem: uibarButtonItem)
            
            newItemToAdd.isBordered = false
            toolbarItemToInsert = newItemToAdd
        case .nsSearchBarCustom:
            if let frameworksPath = Bundle.main.privateFrameworksPath {
                let bundlePath = "\(frameworksPath)/macOSBridging.framework"
                do {
                    //we want to check whether we can load this dependent framework
                    //make sure the name of the framework is correct
                    try Bundle(path: bundlePath)?.loadAndReturnError()
                    _ = Bundle(path: bundlePath)! //at this point, we can load this!
                    
                    //we have to use some Objective-C trickery to load the SearchbarToolItem from AppKit
                    if let searchbarToolItemClass = NSClassFromString("macOSBridging.CustomSearchbarToolItem") as? NSToolbarItem.Type {
                        let newItemToAdd = searchbarToolItemClass.init(itemIdentifier: itemIdentifier)
                        newItemToAdd.isBordered = false
                        toolbarItemToInsert = newItemToAdd
                        print("Successfully loaded NSSearchBar into our toolbar!!!")
                    } else {
                        print("There is no class with the name CustomSearchbarToolItem in macOSBridging.framework - make sure you spelled the name correctly")
                    }
                } catch {
                    print("error while loading the dependent framework: \(error.localizedDescription)")
                }
            }
        case .nsSearchBarDefault:
            if let frameworksPath = Bundle.main.privateFrameworksPath {
                let bundlePath = "\(frameworksPath)/macOSBridging.framework"
                do {
                    //we want to check whether we can load this dependent framework
                    //make sure the name of the framework is correct
                    try Bundle(path: bundlePath)?.loadAndReturnError()
                    _ = Bundle(path: bundlePath)! //at this point, we can load this!
                    
                    //we have to use some Objective-C trickery to load the SearchbarToolItem from AppKit
                    if let searchbarToolItemClass = NSClassFromString("macOSBridging.DefaultSearchToolbarItem") as? NSToolbarItem.Type {
                        let newItemToAdd = searchbarToolItemClass.init(itemIdentifier: itemIdentifier)
                        newItemToAdd.isBordered = false
                        toolbarItemToInsert = newItemToAdd
                        print("Successfully loaded ResizableSearchToolbarItem into our toolbar!!!")
                    } else {
                        print("There is no class with the name DefaultSearchToolbarItem in macOSBridging.framework - make sure you spelled the name correctly")
                    }
                } catch {
                    print("error while loading the dependent framework: \(error.localizedDescription)")
                }
            }
        case .favorites:
            // added for example purposes
            let newItemToAdd = NSToolbarItem(itemIdentifier: itemIdentifier)
            newItemToAdd.image = UIImage(systemName: "heart")
            newItemToAdd.label = "Favorites"
            newItemToAdd.isBordered = true
            newItemToAdd.action = #selector(TagsViewController.didClickOnToolbarItem(_:))
            toolbarItemToInsert = newItemToAdd
        case .addnew:
            // added for example purposes
            let newItemToAdd = NSToolbarItem(itemIdentifier: itemIdentifier)
            newItemToAdd.image = UIImage(systemName: "plus")
            newItemToAdd.label = "Add New"
            newItemToAdd.isBordered = true
            newItemToAdd.action = #selector(TagsViewController.didClickOnToolbarItem(_:))
            toolbarItemToInsert = newItemToAdd
        case .share:
            // added for example purposes
            let newItemToAdd = NSToolbarItem(itemIdentifier: itemIdentifier)
            newItemToAdd.image = UIImage(systemName: "square.and.arrow.up")
            newItemToAdd.label = "Share"
            newItemToAdd.isBordered = true
            newItemToAdd.action = #selector(TagsViewController.didClickOnToolbarItem(_:))
            toolbarItemToInsert = newItemToAdd
        case .browse:
            // added for example purposes
            let newItemToAdd = NSToolbarItem(itemIdentifier: itemIdentifier)
            newItemToAdd.image = UIImage(systemName: "network")
            newItemToAdd.label = "Browse"
            newItemToAdd.isBordered = true
            newItemToAdd.action = #selector(TagsViewController.didClickOnToolbarItem(_:))
            toolbarItemToInsert = newItemToAdd
        default:
            break
        }
        
        return toolbarItemToInsert
    }
}

extension NSToolbarItem.Identifier {
    static let favorites = NSToolbarItem.Identifier("topDomain.company.application.toolbaritem.favorites")
    static let uiSearchBar = NSToolbarItem.Identifier("topDomain.company.application.toolbaritem.uisearchbar")
    static let nsSearchBarCustom = NSToolbarItem.Identifier("topDomain.company.application.toolbaritem.nsSearchBarCustom")
    static let nsSearchBarDefault = NSToolbarItem.Identifier("topDomain.company.application.toolbaritem.nsSearchBarDefault")
    static let addnew = NSToolbarItem.Identifier("topDomain.company.application.toolbaritem.addnew")
    static let share = NSToolbarItem.Identifier("topDomain.company.application.toolbaritem.share")
    static let browse = NSToolbarItem.Identifier("topDomain.company.application.toolbaritem.browse")
}

#endif


