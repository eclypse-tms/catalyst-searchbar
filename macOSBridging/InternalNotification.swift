//
//  InternalNotification.swift
//  
//  Created by Turker Nessa Kucuk on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import Foundation

enum InternalNotification: String {
    case toolbarSearchBarTextChanged = "topDomain.companyName.app.notification.searchbartextchanged"
    
    var name: NSNotification.Name {
        return NSNotification.Name(rawValue: self.rawValue)
    }
}
