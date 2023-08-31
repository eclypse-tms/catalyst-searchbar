//
//  TagsLayoutSection.swift
//  
//  Created by Deniz Nessa on 8/31/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import UIKit
import Composure

enum TagsLayoutSection: Int, DefinesCompositionalLayout, CaseIterable {
    case allTags
    
    func layoutInfo(using layoutEnvironment: NSCollectionLayoutEnvironment) -> CompositionalLayoutOption {
        switch self {
        case .allTags:
            return .dynamicWidthFixedHeight(estimatedWidth: 60, fixedHeight: 32)
        }
    }
    
    var interGroupSpacing: CGFloat {
        switch self {
        case .allTags:
            return 12
        }
    }
    
    var interItemSpacing: CGFloat {
        switch self {
        case .allTags:
            return 12
        }
    }
    
    func sectionInsets(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSDirectionalEdgeInsets {
        switch self {
        case .allTags:
            return NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        }
    }
}
