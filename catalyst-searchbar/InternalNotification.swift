//
//  InternalNotification.swift
//  
//  Created by Deniz Nessa on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import Foundation

enum InternalNotification: String {
    /// the raw value of this notification name has to match the raw value of the same notification in macOSBridging.InternalNotification
    case toolbarSearchBarTextChanged = "topDomain.companyName.app.notification.searchbartextchanged"
    
    var name: Notification.Name {
        return Notification.Name(rawValue: self.rawValue)
    }
}
