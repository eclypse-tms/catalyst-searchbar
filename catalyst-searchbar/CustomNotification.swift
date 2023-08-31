//
//  CustomNotification.swift
//  
//  Created by Turker Nessa Kucuk on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import Foundation

enum CustomNotification: String {
    case searchTextDidChange
    
    var name: Notification.Name {
        return Notification.Name(rawValue: self.rawValue)
    }
}
