//
//  TagCell.swift
//  
//  Created by Turker Nessa Kucuk on 8/30/23.
//  Copyright © 2023 Eclypse Software, LLC. All rights reserved.
//  

import UIKit

class TagCell: UICollectionViewCell, NibLoadable {

    @IBOutlet private weak var cardBackground: UIView!
    @IBOutlet private weak var tagLabel: UILabel!
    @IBOutlet private weak var tagImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardBackground.roundCorners(cornerRadius: 8)
    }
    
    func configure(with viewModel: TagViewModel) {
        self.tagLabel.text = viewModel.name
        self.tagImage.tintColor = UIColor(knownValidHex: viewModel.hexColor)
    }

}
