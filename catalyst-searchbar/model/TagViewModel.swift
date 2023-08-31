//
//  TagViewModel.swift
//  
//  Created by Deniz Nessa on 8/30/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import Foundation

struct TagViewModel: Hashable {
    let id: String
    let name: String
    let hexColor: String
    
    init(name: String, hexColor: String) {
        self.id = UUID().uuidString
        self.name = name
        self.hexColor = hexColor
    }
}
